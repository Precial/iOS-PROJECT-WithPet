//
//  ContentViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/01.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MVVM
    
    // Model
    // - ContentInfo
    // > ContentInfo 만들자
    
    // View
    // - ListCell
    // > ListCell 필요한 정보를 ViewModel한테서 받아야겠다
    // > ListCell은 ViewModel로 부터 받은 정보로 뷰 업데이트 하기
    
    // ViewModel
    // - ContentViewModel
    // > ContentViewModel을 만들고, 뷰레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기 ,, ContentInfo 들
    
    let viewModel = ContentViewModel()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController 데이터 줄꺼에요
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int {

                let contentInfo = viewModel.contentInfo(at: index)
                vc?.viewModel.update(model: contentInfo)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfContentInfoList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        
        let contentInfo = viewModel.contentInfo(at: indexPath.row)
        cell.update(info: contentInfo)
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--> \(indexPath.row)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
}

class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func update(info: ContentInfo) {
        imgView.image = info.image
        nameLabel.text = info.name
        contentLabel.text = "\(info.content)"
    }
}

class ContentViewModel {
    let contentInfoList: [ContentInfo] = [
        ContentInfo(name: "brook", content: 33000000),
        ContentInfo(name: "chopper", content: 50),
        ContentInfo(name: "franky", content: 44000000),
        ContentInfo(name: "luffy", content: 300000000),
        ContentInfo(name: "nami", content: 16000000),
        ContentInfo(name: "robin", content: 80000000),
        ContentInfo(name: "sanji", content: 77000000),
        ContentInfo(name: "zoro", content: 120000000)
    ]
    
    var sortedList: [ContentInfo] {
        let sortedList = contentInfoList.sorted { prev, next  in
            return prev.content > next.content
        }
        
        return sortedList
    }
    
    var numOfContentInfoList: Int {
        return contentInfoList.count
    }
    
    func contentInfo(at index: Int) -> ContentInfo {
        return sortedList[index]
    }
}
