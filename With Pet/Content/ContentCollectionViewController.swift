//
//  ContentCollectionViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/03.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit

class ContentCollectionViewController: UIViewController {

    let viewModel = ContentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
    
extension ContentCollectionViewController: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfCotentInfoList
    }
    
     // 셀 어떻게 표시 할까?
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          // TODO: 셀 구성하기
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let info = viewModel.contentInfo(at: indexPath.row)
        cell.updateUI(item: info)
             return cell
        

      }

    
    // 헤더뷰 어떻게 표시할까?
      func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
   
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Typesomethingheader", for: indexPath) as? ContentCollectionHeaderView else {
            
            return UICollectionReusableView ()
        }
        
        header.updateUI()
     return header
    
    }
}
    
    extension ContentCollectionViewController: UICollectionViewDelegate {
        // 클릭했을때 어떻게 할까?
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // TODO: 곡 클릭시 플레이어뷰 띄우기
        }
    }

    extension ContentCollectionViewController: UICollectionViewDelegateFlowLayout {
            // 셀 사이즈 어떻게 할까?
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                // 20 - card(width) - 20 - card(width) - 20
                let width: CGFloat = (collectionView.bounds.width - (20 * 3))/2
                let height: CGFloat = width + 60
                return CGSize(width: width, height: height)
            }
        }




class ContentViewModel {
    let contentInfoList: [Content] = [
        Content(name: "brook", adress: "33000000"),
        Content(name: "chopper", adress: "50"),
        Content(name: "franky", adress: "44000000"),
        Content(name: "luffy", adress: "300000000"),
        Content(name: "nami", adress: "16000000"),
        Content(name: "robin", adress: "80000000"),
        Content(name: "sanji", adress: "77000000"),
        Content(name: "zoro", adress: "120000000")
    ]
    
//    var sortedList: [Content] {
//        let sortedList = cotentInfoList.sorted { prev, next  in
//            return prev.cotent > next.cotent
//        }
        
//        return contentInfoList
    
        var numOfCotentInfoList: Int {
            return contentInfoList.count
       }
    func contentInfo(at index: Int) -> Content{
           return contentInfoList[index]
       }
    }
    

    
   

