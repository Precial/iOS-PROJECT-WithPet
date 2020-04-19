//
//  ViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/01.
//  Copyright © 2020 com.sg. All rights reserved.
//

/* To do - 키보드 내리기 기능 추가하기 */

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController {
    

    

    
    // 로그인 입력 inputTextbox 연결
    @IBOutlet weak var loginID: UITextField!
    @IBOutlet weak var loginPW: UITextField!
    
    // 외부 로그인 버튼
    @IBOutlet weak var kakaoBtn: UIButton!
    @IBOutlet weak var FacebookBtn: UIButton!
 
    @IBOutlet weak var appleBtn: UIButton!
    
    
    // 앱이 처음 로드될때
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true // 네비게이션 바 숨기기
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        Auth.auth().addStateDidChangeListener({ (user, err) in
                  
                  let user = false
                  if user != nil {
                      self.performSegue(withIdentifier: "loginNext", sender: self)
                  } else{
                      
                  }
              })
        
        
    
    }
    
    // 앱이 RE 로드될때
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true // 네비게이션 바 숨기기
    }
    
     //Login 클릭할시 ->
    @IBAction func loginButton(_ sender: Any) {
        
        /* 테스트 모드 */
     //   self.performSegue(withIdentifier: "loginNext", sender: self)
        
        /* 상용모드 */
        Auth.auth().signIn(withEmail: loginID.text!, password: loginPW.text!){
            (user, error) in if user != nil {
                print("로그인 성공")
                self.performSegue(withIdentifier: "loginNext", sender: self)
            } else {
                print("로그인 불가")
                self.loginFailMessage()
            }
        }
     
    }
    
    
    // 회원가입 클릭할시 ->
    @IBAction func createUser(_ sender: Any) {
        // 네이게이션 별도의 옵션, 제한 없이 바로 이동 설정
    }
    
    // 비밀번호 찾기 클릭할시 ->
    @IBAction func rePassword(_ sender: Any) {
    }
    

    @IBAction func googleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    // 로그인 실패 알람창 띄우기
    func loginFailMessage() {
         
         let message = "아이디/ 비밀번호가 맞지 않습니다."
                   let alert = UIAlertController(title: "로그인 실패", message: message, preferredStyle:.alert)
                   let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                      alert.addAction(action)
                    present(alert,animated: true, completion: nil)
     }
    

}

