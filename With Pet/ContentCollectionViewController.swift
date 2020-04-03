//
//  ContentCollectionViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/03.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit

class ContentCollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
    
extension ContentCollectionViewController: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
     // 셀 어떻게 표시 할까?
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          // TODO: 셀 구성하기
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else {
            return UICollectionViewCell()
                
        }
          return cell
      }
    // 헤더뷰 어떻게 표시할까?
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                // TODO: 헤더 구성하기
                return UICollectionReusableView()
            default:
                return UICollectionReusableView()
            }
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
            // TODO: 셀사이즈 구하기
            return CGSize(width: 194, height: 241)
        }
    }


