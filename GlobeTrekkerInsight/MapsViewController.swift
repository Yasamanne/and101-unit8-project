//
//  MapsViewController.swift
//  GlobeTrekkerInsight
//
//  Created by Yasaman Emami on 11/17/23.
//

import UIKit
import WebKit

class MapsViewController: UIViewController {
    var mapURL: String?
    
    
    @IBOutlet weak var mapView: WKWebView!
    @IBOutlet weak var logoImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: mapURL ?? "") {
            var request = URLRequest(url: url)
            mapView.load(request)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        if let url = URL(string: mapURL ?? "") {
            var request = URLRequest(url: url)
            mapView.load(request)
        }
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
