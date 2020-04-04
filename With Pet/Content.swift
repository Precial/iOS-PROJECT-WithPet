//
//  Content.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/03.
//  Copyright © 2020 com.sg. All rights reserved.
//
import UIKit

struct Content {
    let name: String
    let adress: String
   
    
    var image: UIImage? {
           return UIImage(named: "\(name).jpg")
       }
    init(name: String, adress: String ) {
        self.name = name
        self.adress = adress
    }
}
