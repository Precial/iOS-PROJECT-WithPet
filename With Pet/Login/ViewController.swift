//
//  ViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/01.
//  Copyright © 2020 com.sg. All rights reserved.
//
//  앱이 최초로 나타나는 컨트롤러로 로그인을 하는 페이지
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit


class ViewController: UIViewController, LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if(result?.token == nil){return}
      let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            // ...
            return
          }
        
        }
        
        /* 페이스북 로그인 후 로그아웃하고 파이어베이스 로그인으로 넘어가기 */
        LoginManager().logOut();
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
      
    }
    

    /* 로그인 입력 inputTextbox 연결 */
    @IBOutlet weak var loginID: UITextField!  // 아이디 입력창
    @IBOutlet weak var loginPW: UITextField!  // 패스워드 입력창
    
    /* 외부 로그인 버튼 연결 */
    @IBOutlet weak var kakaoBtn: UIButton!
    @IBOutlet weak var appleBtn: UIButton!
    
    @IBOutlet weak var fackbookLoginBtn: FBLoginButton!
    
    /* viewDidLoad()는 앱이 화면에 로드 될때 동작하는 부분 */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* 깔끔한 UI로 보이기 위해 네이게이션 바 숨기기 */
        navigationController?.navigationBar.isHidden = true // true: 숨기기, false: 나타내기
        
        /* 구글로그인 연동 컨트롤러 연결을해당 현재 컨트롤로 값으로 부여 */
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        
        /* 페이스북 로그인 버튼 연동 */
        fackbookLoginBtn.delegate = self
        
        /* Auth.auth().addStateDidChangeListener는 로그인 상태가 변할때 동작하는 부분 */
        Auth.auth().addStateDidChangeListener { (auth, user) in
                  if let user = user {
                    self.performSegue(withIdentifier: "loginNext", sender: self) // 현재 사용자가 로그인 된 상태가 맞다면 다음 화면으로 이동
                    }
            }
    }
    
    
    /* 앱이 다시 로그 될때 동작하는 부분 */
        override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true // 다시 초기화면으로 돌아 왔을때 네이게이션 바 제거
    }
    
    
    
     /* 로그인 버튼 클릭시 동작하는 부분*/
     @IBAction func loginButton(_ sender: Any) {
        
        /* 테스트 모드 */
        // self.performSegue(withIdentifier: "loginNext", sender: self)
        
        /* 상용모드 */
        Auth.auth().signIn(withEmail: loginID.text!, password: loginPW.text!){ // 입력한 ID,PW로 로그인 인증하는 부분
            (user, error) in if user != nil {
                print("로그인 성공")
                // 로그인시 ID,PW 입력창 초기화
                self.loginID.text!=""
                self.loginPW.text!=""
            } else {
                print("로그인 불가")
                self.loginFailMessage() // 로그인 실패시 에러 알림창 출력 함수 호출
            }
        }
     
    }
    
    
    /*  회원가입 클릭할시 동작하는 부분 */
    @IBAction func createUser(_ sender: Any) {
        // 네이게이션 별도의 옵션, 제한 없이 바로 이동 설정
    }
    
    /* 비밀번호찾기 클릭할시 동작하는 부분 */
    @IBAction func rePassword(_ sender: Any) {
        // 네이게이션 별도의 옵션, 제한 없이 바로 이동 설정
    }
    
    /* 구글 로그인 버튼 클릭할시 동작하는 부분 */
    @IBAction func googleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn() // 구글 로그인 불러오기
    }
    

    
    
    /* 로그인 실패시 알람창 띄우는 함수 */
    func loginFailMessage() {
         let message = "아이디/ 비밀번호가 맞지 않습니다."
         let alert = UIAlertController(title: "로그인 실패", message: message, preferredStyle:.alert)
         let action = UIAlertAction(title: "확인", style: .default, handler: nil)
         alert.addAction(action)
         present(alert,animated: true, completion: nil)
     }
    
}

