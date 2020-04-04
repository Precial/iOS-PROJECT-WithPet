//
//  ContentCollectionHeaderView.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/04.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit

class ContentCollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var headerImage: UIImageView!
    
    func updateUI(){
        headerImage.image = UIImage(named: "nami.jpg")
    }
    //           @IBOutlet weak var thumbnailImageView: UIImageView!
//            @IBOutlet weak var descriptionLabel: UILabel!
//
//
//            func update(with item: Content) {
//                thumbnailImageView.image = item.image
//                descriptionLabel.text = item.name
//            }
//
//            @IBAction func cardTapped(_ sender: UIButton) {
//                // TODO: 탭했을때 처리
//            }
        }
