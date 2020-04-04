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

class CreateUserViewController: UIViewController, UITextFieldDelegate {

    // 회원가입 입력 inputTextbox 연결
    @IBOutlet weak var createID: UITextField!
    @IBOutlet weak var createPW: UITextField!
    
    // 프로필 파일 사진 이미지뷰 연결
    @IBOutlet weak var profileImage: UIImageView!
    
    // 알람창 띄우는 메시지 변수
    var createMessage: String = ""
    var createTrue: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // 가입하기 버튼 클릭시 ->
    @IBAction func createUser(_ sender: Any) {
        Auth.auth().createUser(withEmail: createID.text!, password: createPW.text!) {
                      (user, error) in
                      if user != nil {
                        self.createMessage = "회원가입이 완료되었습니다."
                        self.createTrue = true
                        self.createUserMessage(msg: self.createMessage)
                      } else {
                            
                            self.createMessage = "이미 동일한 계정이 있습니다."
                            self.createTrue = false
                            self.createUserMessage(msg: self.createMessage)
                      }
                  }
              }
    
    // 취소하기 버튼 클릭시 ->
    @IBAction func createCancle(_ sender: Any) {
        navigationController?.popViewController(animated: true) // 네이게이션 직전 페이지로 이동
    }
    
    // 이미지 업로드 버튼 클릭시 ->
    @IBAction func uploadImage(_ sender: Any) {
    }
    
    // 알람창 띄우는 함수
    func createUserMessage(msg: String) {
           
           let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "확인", style: .default){
               UIAlertAction in
                if self.createTrue {
                self.navigationController?.popViewController(animated: true)
                }
         })
        present(alert, animated: true, completion: nil)
       }
   

}
