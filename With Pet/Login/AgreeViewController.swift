//
//  AgreeViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/04/17.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit

class AgreeViewController: UIViewController {

    var receiveCode=0
    
    @IBOutlet weak var codeCheck: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false

        codeCheck.text = "\(receiveCode)"
    }
    

 

}
