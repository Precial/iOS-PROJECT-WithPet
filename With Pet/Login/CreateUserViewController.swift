//
//  CreateUserViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/01.
//  Copyright © 2020 com.sg. All rights reserved.
//
//  회원가입 페이지
//

/* To do - 아이디 및 비밀번호 입력시 글자 수 제한 및 기타 예외처리 하기. */

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class CreateUserViewController: UIViewController, UITextFieldDelegate {
    
    /* 디비 연결 변수 */
    var db: Firestore!
    
    /* 이용 약관 체크 변수*/
    var agreeNextCode = 0
    
    /* 이미지 컨트롤러 가져오기 */
     let picker = UIImagePickerController()
    
    /* 회원가입 입력시 필요한 필드 연결 */
    @IBOutlet weak var createID: UITextField!
    @IBOutlet weak var createPW: UITextField!
    @IBOutlet weak var createPW2: UITextField!
    @IBOutlet weak var createName: UITextField!
    
    /* 프로필 사진 이미지뷰 */
    @IBOutlet weak var imgUpload: UIImageView!
    
    /* 이용약관 체크버튼 */
    @IBOutlet weak var agreeCheckButton: UIButton!
    @IBOutlet weak var agreeCheckButton2:  UIButton!
    
    /* 알람창 띄우는 메시지 변수 */
    var createMessage: String = ""
    var createTrue: Bool = false
  
    /* 앱이 로드될때 동작하는 부분 */
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true // 네비게이션 바 숨기기
        picker.delegate = self // 이미지 컨트롤러의 참조를 현재컨트롤러로 입력
 
            /* 파이에베이스에 저장 세팅 */
            let settings = FirestoreSettings()
            Firestore.firestore().settings = settings
            db = Firestore.firestore()
    }

     /* 앱이 RE 로드 될 때 */
       override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = true // 네비게이션 바 숨기기
       }
    

    // 프로필 업로드
    @IBAction func profileUpload(_ sender: Any) {
        
    }
    
    /* 취소하기 버튼을 클릭할 시 동작하는 부분 */
    @IBAction func cancleButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /* 가입하기 버튼 클릭시 동작하는 부분 */
    @IBAction func createUser(_ sender: Any) {
        if self.createPW.text! == self.createPW2.text!{  // 비밀번호랑 재확인 비밀번호가 일치하는지 확인
            if self.agreeCheckButton.isSelected && self.agreeCheckButton2.isSelected{ // 약관동의가 모두 되어 있는지 확인
               creatUserComplete() // 비밀번호 일치 & 약관을 모두 동의 할 경우 회원가입 하는 함수 호출
            } else {
                createStopMessage(msg: "약관을 모두 동의해주세요.") // 약관을 모두 동의하지 않은 경우 알람창 호출
            }
        } else{
            createStopMessage(msg: "비밀번호가 일치하지 않습니다.") // 비밀번호가 일치하지 않은 경우 알람창 호출
        }
    }
    
    /* 약관 동의 버튼 클릭시 동작하는 부분 */
    @IBAction func agreeCheckBtn(_ sender: Any) {
        agreeCheckButton.isSelected = !agreeCheckButton.isSelected // 클릭할때 마다 상태 값 변화
    }
    @IBAction func agreeCheckBtn2(_ sender: Any) {
          agreeCheckButton2.isSelected = !agreeCheckButton2.isSelected // 클릭할때 마다 상태 값 변화
    }
   
    /* 키보드창 내리기 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    
    
    /*
       이용약관 내용보기 클릭시 동작하는 부분
       code 0: 이용약관 동의
       code 1: 개인정보 수집
       -> 파이어베이스 서버에서 코드에 맞는 약관동의를 불러오기 위하여 각각의 코드부여
    */
    @IBAction func agreeContent1(_ sender: Any) {
        agreeNextCode=0
        agreePageNext()
    }
    @IBAction func agreeContent2(_ sender: Any) {
        agreeNextCode=1
        agreePageNext()
    }
    
    /* 약관내용보기 클릭시 동작하는 부분 */
    func agreePageNext(){
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier:"showAgree") as? AgreeViewController else {
            return
        }
        rvc.receiveCode = self.agreeNextCode // 약관동의 페이지의 사용자가 누른 약관동의 코드를 전송
        self.navigationController?.pushViewController(rvc, animated: true) // 약관내용보기로 이동
    }
    
    /* 회원가입을 진행하는 부분 */
    func creatUserComplete(){
           Auth.auth().createUser(withEmail: createID.text!, password: createPW.text!) { // 가입할 이메일과 비밀번호를 입력
                              (user, error) in
                              if user != nil {
                                self.createMessage = "회원가입이 완료되었습니다."
                                self.adduserData() // 파이어베이스 스토리지에도 회원정보를 저장하는 함수 호출
                                self.createTrue = true // 회원가입을 진행해도 되는 비교 값
                                
                                /* 전송할 이미지를 데이터로 변환 */
                                guard let sendimage = self.imgUpload.image, let dataa = sendimage.jpegData(compressionQuality: 1.0) else {
                                           return
                                       }
                                 
                                /* 이미지를 저장할 path 설정 */
                                let imageName = "\(self.createName.text!).jpg"
                                let riversRef = Storage.storage().reference().child("User_ProfileImage").child(self.createID.text!).child(imageName)
                                
                                
                                /* 사용자가 선택한 이미지를 서버로 전송하는 부분 */
                                riversRef.putData(dataa, metadata: nil) { (metadata, error) in
                                guard let metadata = metadata else {
                                // Uh-oh, an error occurred!
                                return
                                }
                                
                                // Metadata contains file metadata such as size, content-type.
                                let size = metadata.size
                                // You can also access to download URL after upload.
                                riversRef.downloadURL { (url, error) in
                                guard let downloadURL = url else {
                                // Uh-oh, an error occurred!
                                return
                                          }
                                      }
                                  }
                                
                                /* 회원가입 완료 알람창 호출 */
                                self.createStopMessage(msg: self.createMessage)
                              } else {
                                    /* 회원정보가 올바르지 않을 경우 알람창 호출 */
                                    self.createMessage = "이미있는 계정이거나 입력하신 정보가 올바르지 않습니다."
                                    self.createTrue = false
                                self.createStopMessage(msg: self.createMessage)
                              }
                          }
        }
    
    /* 회원가입 클릭시 성공 or 실패를 알려주는 함수 */
    func createStopMessage(msg: String){
        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                               alert.addAction(UIAlertAction(title: "확인", style: .default){
                               UIAlertAction in
                                  if self.createTrue {
                                    self.dismiss(animated: true, completion: nil)
                                }
                         })
                        present(alert, animated: true, completion: nil)
    }
    
    /* 회원가입 성공 시 사용자 정보를 파이에베이스 스토리지에 저장 */
    private func adduserData() {
        db.collection("users").document(self.createID.text!).setData([
                   "ID": self.createID.text!,
                   "Password": self.createPW.text!,
                   "Name": self.createName.text!
                 ]) { err in
                     if let err = err {
                         print("Error writing document: \(err)")
                     } else {
                         print("Document successfully written!")
                     }
                 }
       }
    
    
    
    @IBAction func addImage(_ sender: Any) {
        let alert =  UIAlertController(title: "원하는 타이틀", message: "원하는 메세지", preferredStyle: .actionSheet)
                let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
                }
                let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
                    self.openCamera()
                }
                let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                
                alert.addAction(library)
                alert.addAction(camera)
                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)
    }
    
      func openLibrary()
      {
          picker.sourceType = .photoLibrary
          present(picker, animated: false, completion: nil)

      }
      func openCamera()
      {
          if(UIImagePickerController .isSourceTypeAvailable(.camera)){
              picker.sourceType = .camera
              present(picker, animated: false, completion: nil)
          }
          else{
              print("Camera not available")
          }
      }
    
}
extension CreateUserViewController : UIImagePickerControllerDelegate,
UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[.originalImage] as? UIImage {
            imgUpload.image = image
            print(info)
         
        }
        
        

        dismiss(animated: true, completion: nil)

    }
}

