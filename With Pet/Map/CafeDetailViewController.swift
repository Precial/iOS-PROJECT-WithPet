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
    var UID: String?

    var ResponeName: String = ""
    
    
    // 버튼 상태에 따른 메시지 저장
    var btnStateMessage=""
    
    
    // pick 버튼 연결
    @IBOutlet weak var pickBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ResponeName = self.detailRespone!
        
        
       
        print("~~~ 해당 값은: \(UID)")
        
        
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
                
          })
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel){

          UIAlertAction in

          })
        
        
        
         present(alert, animated: true, completion: nil)
        }
    
    
    
    
    
 

}
