//
//  ViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/01.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    // 로그인 입력 inputTextbox 연결
    @IBOutlet weak var loginID: UITextField!
    @IBOutlet weak var loginPW: UITextField!
    
    // 앱이 처음 로드될때
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationController?.navigationBar.isHidden = true // 네비게이션 바 숨기기
        
    }
    
     //Login 클릭할시 ->
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "loginNext", sender: self)
    }
    
    
    // 회원가입 클릭할시 ->
    @IBAction func createUser(_ sender: Any) {
        // 네이게이션 별도의 옵션, 제한 없이 바로 이동 설정
    }
    
    // 비밀번호 찾기 클릭할시 ->
    @IBAction func rePassword(_ sender: Any) {
    }
    
    // 카카오 로그인 클릭할시 ->
    @IBAction func kakaoLoign(_ sender: Any) {
    }
    
    
    
}

