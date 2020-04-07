//
//  CreateUserViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/01.
//  Copyright © 2020 com.sg. All rights reserved.
//

/* To do - 아이디 및 비밀번호 미 입력시 입력 안내 문구 표시 */
/* To do - 아이디 및 비밀번호 입력시 글자 수 제한 및 기타 예외처리 하기. */
/* To do - 로그아웃시 네이게이션 탭바 다시 제거하기  */


import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore



class CreateUserViewController: UIViewController, UITextFieldDelegate {
    
    // 디비 변수
    var db: Firestore!
    
    // 이미지 가져오기
     let picker = UIImagePickerController()
    


    // 회원가입 입력 inputTextbox 연결
    @IBOutlet weak var createID: UITextField!
    @IBOutlet weak var createPW: UITextField!
    @IBOutlet weak var createPW2: UITextField!
    @IBOutlet weak var createName: UITextField!
    
    // 프로필 파일 사진 이미지뷰 연결

    @IBOutlet weak var imgUpload: UIImageView!
    
    
    // 이용약관 체크버튼
    @IBOutlet weak var agreeCheckButton: UIButton!
    @IBOutlet weak var agreeCheckButton2:  UIButton!
    
    // 알람창 띄우는 메시지 변수
    var createMessage: String = ""
    var createTrue: Bool = false
  
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
 
        // [START setup]
            let settings = FirestoreSettings()

            Firestore.firestore().settings = settings
            // [END setup]
            db = Firestore.firestore()
  

    }

    // 취소하기 버튼 클릭시 ->
   
    @IBAction func cancleButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // 가입하기 버튼 클릭시 ->
    @IBAction func createUser(_ sender: Any) {
        if self.createPW.text! == self.createPW2.text!{
            if self.agreeCheckButton.isSelected && self.agreeCheckButton2.isSelected{
               creatUserComplete()
            } else {
                createStopMessage(msg: "약관을 모두 동의해주세요.")
            }

        } else{
            createStopMessage(msg: "비밀번호가 일치하지 않습니다.")
        }
        
              }
    


    // 약관 동의 버튼 클릭시 ->
    @IBAction func agreeCheckBtn(_ sender: Any) {
        agreeCheckButton.isSelected = !agreeCheckButton.isSelected
    }
    
    @IBAction func agreeCheckBtn2(_ sender: Any) {
          agreeCheckButton2.isSelected = !agreeCheckButton2.isSelected
    }
//    
    
    // 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
    
    
  
    func creatUserComplete(){
           Auth.auth().createUser(withEmail: createID.text!, password: createPW.text!) {
                              (user, error) in
                              if user != nil {
                                self.createMessage = "회원가입이 완료되었습니다."
                                self.adduserData()
                                self.createTrue = true
                                self.createStopMessage(msg: self.createMessage)
                              } else {
                                    self.createMessage = "이미있는 계정이거나 입력하신 정보가 올바르지 않습니다."
                                    self.createTrue = false
                                self.createStopMessage(msg: self.createMessage)
                              }
                          }
    }
    

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

