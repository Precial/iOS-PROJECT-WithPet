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


class ListMapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let nameList = ["펫고펫", "오늘의 펫", "도그앤캣","펫스타그램","펫킷"]
    let adressList = ["서울시 강남구","서울시 서초구", "서울시 관악구","서울시 마포구","서울시 구로구"]
 
    

    
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
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameList.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
            
        }
        
        let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
        //cell.imageView.image = img
        cell.nameLabel.text = nameList[indexPath.row]
        cell.adressLabel.text = adressList[indexPath.row]
        return cell
     }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("--> \(indexPath.row)")
    }

}


class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
     
     
     
     
 }
