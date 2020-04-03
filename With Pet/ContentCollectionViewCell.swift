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
        
        override func awakeFromNib() {
            super.awakeFromNib()
            contentImage.layer.cornerRadius = 4
            contentAdress.textColor = UIColor.systemGray2
        }
        
        func updateUI(item: Content?) {
       
            
        }
    }
