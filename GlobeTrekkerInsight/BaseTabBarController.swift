//
//  BaseTabBarController.swift
//  GlobeTrekkerInsight
//
//  Created by Yasaman Emami on 11/17/23.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    var userInputValue: String = ""
    var mapURL: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        print("tab bar", mapURL)
    }
    

    

}
