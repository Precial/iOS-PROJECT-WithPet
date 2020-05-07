//
//  ListMapViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/05/04.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


class ListMapViewController: UIViewController {

    
    var db:Firestore!
    
    var respone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("-----넘어옴------")
        print(respone)
        cafeLoad(input: respone)
    }
    

 
    
    
    func cafeLoad(input:String){
        db = Firestore.firestore()
    
        print("======***********==============")
        
        db.collection(input).getDocuments(){ (querySnapshot, err) in
                                  if let err = err {
                                  print("Error getting documents: \(err)")
                                  } else {
                                      
                                   let cnt = querySnapshot!.documents.count
                                   print("카페 개수 :::: \(cnt)")
                                 
                                  
                                   for document in querySnapshot!.documents {
                                       
                                       let info = document.data()
                                        print("카페 정보 :::: \(info)")
                                       
                                       guard let name = info["name"] else {return}
                                       guard let loc1 = info["loc1"] else {return}
                                        guard let loc2 = info["loc2"] else {return}
                                        guard let which = info["which"] else {return}
                                       
                                       print(name)
                                       print(loc1)
                                       print(loc2)
                                       print(which)
                                       print("----------------")
                                       
            
                                       
                                       
                                   }
                                       }
                                  }
        
        
        
        
    }
}
