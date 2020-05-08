//
//  CafeDetailViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/05/07.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
class CafeDetailViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    
    var name: String?
    var adress: String?
    var imgName: String?
    var detailRespone: String?

    var ResponeName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ResponeName = self.detailRespone!
        updateUI()
         
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
    
    
    
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
 

}
