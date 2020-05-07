//
//  CafeDetailViewController.swift
//  With Pet
//
//  Created by 장성구 on 2020/05/07.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit

class CafeDetailViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    
    var name: String?
    var adress: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    func updateUI() {
        
        if let name = self.name, let adress = self.adress {
            
            //imgView.image = UIImage(named: "\(name).jpg")
            nameLabel.text = name
            adressLabel.text = adress
        }
    }
    
    
    
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
 

}
