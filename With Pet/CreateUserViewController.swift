//
//  CreateUserViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/01.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {

    // 회원가입 입력 inputTextbox 연결
    @IBOutlet weak var createID: UITextField!
    @IBOutlet weak var createPW: UITextField!
    
    // 프로필 파일 사진 이미지뷰 연결
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 가입하기 버튼 클릭시 ->
    @IBAction func createUser(_ sender: Any) {
    }
    
    // 취소하기 버튼 클릭시 ->
    @IBAction func createCancle(_ sender: Any) {
        navigationController?.popViewController(animated: true) // 네이게이션 직전 페이지로 이동
    }
    
    // 이미지 업로드 버튼 클릭시 ->
    @IBAction func uploadImage(_ sender: Any) {
    }
    
   

}
