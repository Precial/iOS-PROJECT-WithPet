//
//  CafeDetailViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/05/07.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
class CafeDetailViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    
    var name: String?
    var adress: String?
    var imgName: String?
    var detailRespone: String?
    var UID: String?
    var realUID: String = ""
   
    
    
    var ResponeName: String = ""
    
    
    // 버튼 상태에 따른 메시지 저장
    var btnStateMessage=""
    
     var db: Firestore!
     var handle: AuthStateDidChangeListenerHandle?
    
    
     var nowUserKey = ""
    
    
    // pick 버튼 연결
    @IBOutlet weak var pickBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ResponeName = self.detailRespone!
        
    
        if let temp = UID {
        print("해당 값은: \(temp)")
            self.realUID = "\(temp)"
            print("해당 값은: \(self.UID)")
        }
        
        
        
        /* 현재 로그인한 유저 확인 */
    
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        
        // 현재 로그인한 유저 확인
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        if let user = user {
                    
                     guard let email = user.email else {return }
                     self.nowUserKey = email
                     print("~~~ 값은 : \(email)")
               }
              }
        
       
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
                                  
                                    print(ID)
                                    print(Password)
                                    print(Name)
                            
                            }
        
                        }
            }
       
         
    }
         updateUI()
    }
    
    
    /* UID  저장 */
    private func adduserData() {
        let uidPath = "\(self.nowUserKey)/selectedCafe\(self.realUID)"
        print("~~~")
        print("~~~ \(self.realUID)")
      //  print("~~~ \(self.nowUserKey)/selectedCafe/\(self.UID)")
        
        
        db.collection("users").document("\(self.nowUserKey)/selectedCafe/List\(self.realUID)").setData([
                   "UID": self.realUID

                 ]) { err in
                     if let err = err {
                         print("Error writing document: \(err)")
                     } else {
                         print("Document successfully written!")
                     }
                 }
        
        
        
 
        
        
        /* 데이터 업데이트 */
//        let washingtonRef = db.collection("users").document(self.nowUserKey)
//
//        // Set the "capital" field of the city 'DC'
//        washingtonRef.updateData([
//            "testUID": self.UID
//        ]) { err in
//            if let err = err {
//                print("Error updating document: \(err)")
//            } else {
//                print("Document successfully updated")
//            }
//        }
        
       }
    
    
    /* UID  삭제 */
       private func deleteuserData() {
        db.collection("users").document("\(self.nowUserKey)/selectedCafe/List\(self.realUID)").delete()
    
    }
    
    
    
    func updateUI() {
        
        if let name = self.name, let adress = self.adress, let imgName = self.imgName {
            
           
            
            let islandRef = Storage.storage().reference().child("Cafe_Image").child(ResponeName).child("\(imgName).jpg")
                  
            print("~~~~\(ResponeName) 과 \(imgName)")
            
                
                          // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                          islandRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
                          if let error = error {
                          // Uh-oh, an error occurred!
                          print("error")
                          } else {
                          // Data for "images/island.jpg" is returned
                          let image = UIImage(data: data!)
                  
                            self.imgView.image = image
                              }
                          }
            
            //imgView.image = UIImage(named: "\(name).jpg")
            nameLabel.text = name
            adressLabel.text = adress
        }
    }
    
    
    
    @IBAction func myPickBtn(_ sender: Any) {
        
        if pickBtn.isSelected {
            self.btnStateMessage = "정말로 픽을 해제 하시겠습니까?"
        } else {
            self.btnStateMessage = "정말로 픽을 하시겠습니까?"
        }
        
        
        pickSelectMessage()
        //pickBtn.isSelected = !pickBtn.isSelected // 클릭할때 마다 상태 값 변화
    }
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    /* pick 버튼 클릭시 안내 문구 표시 */
     func pickSelectMessage(){
        let alert = UIAlertController(title: "", message: self.btnStateMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default){
                UIAlertAction in
                    
                    self.pickBtn.isSelected = !self.pickBtn.isSelected // 버튼 상태 변화
                    
                    if self.pickBtn.isSelected {
                        self.adduserData()
                    } else {
                         self.deleteuserData()
                    }
                    
                
                
          })
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel){

          UIAlertAction in

          })
        
        
        
         present(alert, animated: true, completion: nil)
        }
    
    
    
    
    
 

}

