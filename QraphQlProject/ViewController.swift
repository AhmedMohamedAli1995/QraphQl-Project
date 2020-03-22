//
//  ViewController.swift
//  QraphQlProject
//
//  Created by Ahmed-Ali on 3/22/20.
//  Copyright © 2020 com.megatrustgroup.asli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NetworkLayer.getUser { [weak self](name, error) in
            if error == nil {
                print("the name is == 💪\(String(describing: name))")
                guard let self = self else {return}
                self.userNameLabel.text = name
            }
            else{
                print("the error is 😞\(error?.localizedDescription ?? "error not found")")
            }
        }
    }


}

