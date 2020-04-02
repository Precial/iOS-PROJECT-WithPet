//
//  ContentInfo.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/01.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit

struct ContentInfo {
    let name: String
    let content: Int
    
    var image: UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
    init(name: String, content: Int) {
        self.name = name
        self.content = content
    }
}
