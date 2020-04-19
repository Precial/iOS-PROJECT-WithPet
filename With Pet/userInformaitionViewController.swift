//
//  userInformaitionViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/07.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore



class userInformaitionViewController: UIViewController {

    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPassword: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    var nowUserKey = ""
    
    var db: Firestore!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    
    
    @IBAction func logOut(_ sender: Any) {
        
        do {
            try  Auth.auth().signOut()
        } catch {
            
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // [START setup]
               let settings = FirestoreSettings()

               Firestore.firestore().settings = settings
               // [END setup]
        db = Firestore.firestore()
        
 
        //
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
               
                guard let email = user.email else {return }
                self.nowUserKey = email
                self.userID.text = user.email
               
  
         }
        }
  
        
        
           // 사용자 목록 돌려서 현재 로그인 한 사용자랑 매칭해서 정보 가져오기 -> 나중엔 목록 돌리지말고 직접 호출 할 수 있도록 수정하기 - 20.04.07 sgjang
           db.collection("users").getDocuments() { (querySnapshot, err) in
                 if let err = err {
                     print("Error getting documents: \(err)")
                 } else {
                     for document in querySnapshot!.documents {
                        
                        if self.nowUserKey == document.documentID {
                         print("현재 로그인한 사용자는 \(document.documentID) => \(document.data())")
                         
                             let info = document.data()
                            
                            guard let ID = info["ID"] else {return}
                            guard let Password = info["Password"] else {return}
                            guard let Name = info["Name"] else {return}
                            
                            
                            // 자료형 문자열로 변환
                            let tempId = "\(ID)"
                            let tempPw = "\(Password)"
                            let tempName = "\(Name)"
                            
                           // self.userID.text = tempId
                           
                            self.userPassword.text = tempPw
                            self.userName.text = tempName
                                
                            
//                            let imageName = "\(self.createName.text!).jpg"
//
//                                                          let riversRef = Storage.storage().reference().child("User_ProfileImage").child(self.createID.text!).child(imageName)
                            
  

                            
                            // Create a reference to the file you want to download
                            let islandRef = Storage.storage().reference().child("User_ProfileImage").child(tempId).child("\(tempName).jpg")

                            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                            islandRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
                              if let error = error {
                                // Uh-oh, an error occurred!
                                print("error")
                              } else {
                                // Data for "images/island.jpg" is returned
                                let image = UIImage(data: data!)
                                
                                print("이미지 값은: \(image)")
                                self.userImage.image = image
                              }
                            }
                            
                            
                            
                            print(ID)
                            print(Password)
                            print(Name)
                        }
                     }
          
                 }
             }
    }
    

    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       // [START remove_auth_listener]
       Auth.auth().removeStateDidChangeListener(handle!)
       // [END remove_auth_listener]
     }

}
