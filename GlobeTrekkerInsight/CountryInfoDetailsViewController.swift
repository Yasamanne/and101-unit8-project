//
//  CountryInfoDetailsViewController.swift
//  GlobeTrekkerInsight
//
//  Created by Yasaman Emami on 11/17/23.
//

import UIKit

class CountryInfoDetailsViewController: UIViewController, DataDelegate {
    @IBOutlet weak var populationLabel: UILabel!
    
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var continentLabel: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var logoImage: UINavigationItem!
    
    @IBOutlet weak var timeZoneLabel: UILabel!
    @IBOutlet weak var startofweekLabel: UILabel!
    var countryName = ""
    var continents: [String]?
    var population:Int?
    var startOfWeek: String?
    var timezones: [String]?
    var area: Double?
    override func viewDidLoad() {
        super.viewDidLoad()

        continentLabel.text = (continents ?? []).joined(separator: " ")
        timeZoneLabel.text = (timezones ?? []).joined(separator: " ")
        populationLabel.text = population != nil ? String(population!) : nil
        areaLabel.text = area != nil ? String(area!) : nil
        startofweekLabel.text = startOfWeek

        print("data is here", countryName)
    }
    func sendData(data: String) {
            // Handle the received data in the first destination view controller
            print("Received data in the first destination: \(data)")
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
