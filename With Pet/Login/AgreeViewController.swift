//
//  AgreeViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/17.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore

class AgreeViewController: UIViewController {

    var receiveCode=0

    
      var db: Firestore!
     
    
    
    @IBOutlet weak var contentLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false

        print("넘어온 코드 값은: \(receiveCode)")
        
        db = Firestore.firestore()
        
        db.collection("Agree").getDocuments() { (querySnapshot, err) in
            if let err = err {
            print("Error getting documents: \(err)")
            } else {
                
                let info = querySnapshot!.documents[self.receiveCode].data()
                print(info)
                
                guard let title = info["Title"] else {return}
                guard let content = info["Content"] else {return}
                                          
                
                // 자료형 문자열로 변환
                let showTitle = "\(title)"
                let showContent = "\(content)"
                
                print(showTitle)
                print(showContent)
                
                self.contentLable.text = showContent
                self.navigationItem.title = showTitle

                
                
                
             }
            }
        }
}



