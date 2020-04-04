//
//  DetailViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/04.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var showAdress: UILabel!
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    
    }
    
    func updateUI() {
        if let contentInfo = viewModel.contentInfo {
            showImage.image = contentInfo.image
            showName.text = contentInfo.name
            showAdress.text = "\(contentInfo.adress)"
        }
    }



}

class DetailViewModel {
    var contentInfo: Content?
    
    func update(model: Content?) {
        contentInfo = model
    }
}
