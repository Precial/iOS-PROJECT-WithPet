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
    

    // 회원가입 입력 inputTextbox 연결
    @IBOutlet weak var createID: UITextField!
    @IBOutlet weak var createPW: UITextField!
    @IBOutlet weak var createPW2: UITextField!
    @IBOutlet weak var createName: UITextField!
    
    // 프로필 파일 사진 이미지뷰 연결
    @IBOutlet weak var profileImage: UIImageView!
    
    // 이용약관 체크버튼
    @IBOutlet weak var agreeCheckButton: UIButton!
    @IBOutlet weak var agreeCheckButton2:  UIButton!
    
    // 알람창 띄우는 메시지 변수
    var createMessage: String = ""
    var createTrue: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    // 이미지 업로드 버튼 클릭시 ->
    @IBAction func uploadImage(_ sender: Any) {
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
           // [START add_ada_lovelace]
           // Add a new document with a generated ID
           var ref: DocumentReference? = nil
           ref = db.collection("users").addDocument(data: [
            "ID": self.createID.text!,
            "Password": self.createPW.text!,
            "Name": self.createName.text!
           ]) { err in
               if let err = err {
                   print("Error adding document: \(err)")
               } else {
                   print("Document added with ID: \(ref!.documentID)")
               }
           }
           // [END add_ada_lovelace]
       }
    
}
