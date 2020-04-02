//
//  DetailViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/02.
//  Copyright © 2020 com.sg. All rights reserved.
//


import UIKit

class DetailViewController: UIViewController {
    
    // MVVM
    
    // Model
    // - ContentInfo
    // > ContentInfo 만들자
    
    // View
    // - imgView, nameLabel, contentlabel
    // > view들은 viewModel를 통해서 구성되기 ?
    
    
    // ViewModel
    // - DetailViewModel
    // > 뷰레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기 ,, ContentInfo 들
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        if let contentInfo = viewModel.contentInfo {
            imgView.image = contentInfo.image
            nameLabel.text = contentInfo.name
            contentLabel.text = "\(contentInfo.content)"
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

class DetailViewModel {
    var contentInfo: ContentInfo?
    
    func update(model: ContentInfo?) {
        contentInfo = model
    }
}
