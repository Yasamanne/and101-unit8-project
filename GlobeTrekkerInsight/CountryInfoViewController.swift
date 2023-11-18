//
//  CountryInfoViewController.swift
//  GlobeTrekkerInsight
//
//  Created by Yasaman Emami on 11/14/23.
//

import UIKit


class CountryInfoViewController: UIViewController {
    
 
    
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var coatButton: UIButton!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    
    var countryName: String?
    var languageValues: [String: [String]]?
    var countryOfficialName: String?
    var currencyName: String?
    var currencySymbol: String?
    var capital: String?
    var countryFlag: String?
    var countryCoatOfArms: String?
    var continents: [String]?
    var population:Int?
    var startOfWeek: String?
    var timezones: [String]?
    var area: Double?
    var mapURL: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        coatButton.addTarget(self, action: #selector(didButtonSelected), for: .touchUpInside)
        loadImage(from: countryFlag, into: flagImageView)
        
        let customColor = UIColor(
            red: CGFloat(248) / 255.0,
            green: CGFloat(180) / 255.0,
            blue: CGFloat(44) / 255.0,
            alpha: 1.0
        )
        
        let labelData: [(String, String?, UIColor)] = [
            ("", "", UIColor.clear),
            ("Country Official Name:", countryOfficialName, UIColor.black),
            ("Capital", capital, customColor),
            ("Languages Spoken:", languageValues?.values.flatMap { $0 }.joined(separator: ", "), UIColor.black),
            ("currancyName:", currencyName?.description, customColor)
        ]
        
        for (index, (labelText1, labelText2, backgroundColor)) in labelData.enumerated() {
            let squareView = UIView()
            squareView.backgroundColor = backgroundColor
            view.addSubview(squareView)
            
            squareView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                squareView.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(index) * 120.0 + 40.0), // Add top margin
                squareView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                squareView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0), // Left margin
                squareView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0), // Right margin
                squareView.widthAnchor.constraint(equalTo: view.widthAnchor),
                squareView.heightAnchor.constraint(equalToConstant: 100.0),
            ])
            
            let label1 = UILabel()
            label1.text = labelText1
            label1.textAlignment = .center
            label1.textColor = UIColor.white // Optional: Set text color
            label1.font = UIFont.boldSystemFont(ofSize: 22.0)
            squareView.addSubview(label1)
            
            label1.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label1.topAnchor.constraint(equalTo: squareView.topAnchor, constant: 10.0),
                label1.leadingAnchor.constraint(equalTo: squareView.leadingAnchor),
                label1.trailingAnchor.constraint(equalTo: squareView.trailingAnchor),
            ])
            
            let label2 = UILabel()
            label2.text = labelText2
            label2.textAlignment = .center
            label2.textColor = UIColor.brown // Optional: Set text color
            label2.font = UIFont.boldSystemFont(ofSize: 20.0)
            squareView.addSubview(label2)
            
            label2.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label2.topAnchor.constraint(equalTo: label1.bottomAnchor),
                label2.leadingAnchor.constraint(equalTo: squareView.leadingAnchor),
                label2.trailingAnchor.constraint(equalTo: squareView.trailingAnchor),
                label2.bottomAnchor.constraint(equalTo: squareView.bottomAnchor, constant: -10.0), // Add bottom margin
            ])
        }
        
    }
    
    
    @IBAction func didButtonSelected(_ sender: Any) {
        
        if coatButton.currentTitle == "Flag"{
            loadImage(from: countryFlag, into: flagImageView)
            coatButton.setTitle("Coat Arms", for: .normal)
        }else{
            loadImage(from: countryCoatOfArms, into: flagImageView)
            coatButton.setTitle("Flag", for: .normal)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Details"{
            if let destinationVC = segue.destination as? CountryInfoDetailsViewController {
                // Pass data to the destination view controller if needed
                
                destinationVC.countryName = countryName ?? ""
                destinationVC.area = area
                destinationVC.population = population
                destinationVC.startOfWeek = startOfWeek
                destinationVC.timezones = timezones
                destinationVC.continents = continents
            }
        }
        if segue.identifier == "MapURL"{
            if let destinationVC = segue.destination as? MapsViewController {
                // Pass data to the destination view controller if needed
                print("kalak", mapURL)
                destinationVC.mapURL = mapURL
                
            }
        }
    }
    func loadImage(from urlString: String?, into imageView: UIImageView) {
            guard let urlString = urlString, let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error downloading image: \(error.localizedDescription)")
                    return
                }

                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            }.resume()
        }
}
