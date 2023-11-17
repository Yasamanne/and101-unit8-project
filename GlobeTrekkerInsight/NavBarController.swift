//
//  NavBarController.swift
//  GlobeTrekkerInsight
//
//  Created by Yasaman Emami on 11/12/23.
//

import UIKit

class NavBarController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Nav Bar"

        // Customize the appearance of the navigation bar
        navigationController?.navigationBar.barTintColor = UIColor.blue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    // Add a left button to the navigation bar
       let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
       navigationItem.leftBarButtonItem = backButton
    }
    @objc func backButtonTapped() {
        // Handle the back button tap action
        navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
