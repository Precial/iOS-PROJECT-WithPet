//
//  ContentViewModel.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/04.
//  Copyright © 2020 com.sg. All rights reserved.
//

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
    
