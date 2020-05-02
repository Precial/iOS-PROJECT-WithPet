//
//  MainMapViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/05/02.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit

class MainMapViewController: UIViewController {
    
    
     //   let latitude = 37.548947;  let longitude = 126.913521 // 합정
    //  let latitude = 37.497934;  let longitude = 127.027549 // 강남

    var send1=1.0
    var send2=1.0
    
    @IBAction func mapo(_ sender: Any) {
        send1 = 37.548947
        send2 = 126.913521
        dataSend()
        
    }
    
    @IBAction func gangnam(_ sender: Any) {
       send1 =  37.497934
        send2 = 127.027549
        dataSend()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
       
    }
    
    
    
    func dataSend(){
        
        guard let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "map") as? MapSelectViewController else{
                  return
              }
          
        vc2.loc1 = self.send1
        vc2.loc2 = self.send2
              
              self.present(vc2,animated: true)
        
    }
}
