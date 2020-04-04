//
//  ContentCollectionViewCell.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/03.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    
        @IBOutlet weak var contentImage: UIImageView!
        @IBOutlet weak var contentName: UILabel!
        @IBOutlet weak var contentAdress: UILabel!
    
        
        func updateUI(item: Content) {
            
           contentImage.image = item.image
           contentName.text = item.name
           contentAdress.text = "\(item.adress)"
            
        }
    }



