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
    @IBOutlet weak var headerName: UILabel!
    @IBOutlet weak var headerAdress: UILabel!
    
    let viewModel = ContentViewModel()
   
    
    var randomValue = arc4random_uniform(7)
    
    
    func updateUI(){
     
        let currentValue = Int(randomValue)
        let pickName = viewModel.contentInfoList[currentValue].name
        let pickAdress = viewModel.contentInfoList[currentValue].adress
        
        
        headerImage.image = UIImage(named: "\(pickName).jpg")
        headerName.text = "\(pickName)"
        headerAdress.text = "\(pickAdress)"
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
