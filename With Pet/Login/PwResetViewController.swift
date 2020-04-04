//
//  PwResetViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/01.
//  Copyright © 2020 com.sg. All rights reserved.
//

/* To do  - SMS 인증 추가 */
/* To do  - 아이디 조회해서 없는 아이디 조회시 경고 알람 띄우기 */
/* To do  - 취소버튼 추가 */

import UIKit
import Firebase
import FirebaseAuth

class PwResetViewController: UIViewController {

    // 비밀번호를 찾을 입력
    @IBOutlet weak var findID: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 비밀번호 재설정 버튼
    @IBAction func sendPwReset(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: findID.text!)
       createUserMessage()
    }
    
    
    // 알람창 띄우는 함수
    func createUserMessage(){
           let alert = UIAlertController(title: "", message: "요청하신 이메일로 발송하였습니다.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "확인", style: .default){
               UIAlertAction in
                self.navigationController?.popViewController(animated: true)
         })
        present(alert, animated: true, completion: nil)
       }
}
