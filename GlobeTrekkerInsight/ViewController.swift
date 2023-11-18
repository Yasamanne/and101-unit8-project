//
//  ViewController.swift
//  GlobeTrekkerInsight
//
//  Created by Yasaman Emami on 11/12/23.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    
    var countryInfo: [Country]?
    var countryName: String?
    var languageValues: [String: [String]]?
    var currencyName: String?
    var currencySymbol: String?
    var capital: [String]?
    var countryOfficialName: String?
    var countryFlag: String?
    var countryCoatOfArms: String?
    var continents: [String]?
    var population:Int?
    var startOfWeek: String?
    var timezones: [String]?
    var area: Double?
    var mapURL: String?
    
    weak var delegate: DataDelegate?
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var globeGif: UIImageView!
    
    @IBOutlet weak var userInput: UITextField!
    weak var secondDestination: DataDelegate?
    var newsInstance = NewsViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let gifURL = Bundle.main.url(forResource: "globe1", withExtension: "gif"),
                   let gifData = try? Data(contentsOf: gifURL),
                   let gifImage = UIImage.gif(data: gifData) {

                    // Set the animated image to the UIImageView
            globeGif.image = gifImage

                    // Optionally, start the animation
            globeGif.startAnimating()
                }
        
        if let textField = userInput {
            textField.delegate = self
        }
        let tabBar = tabBarController as! BaseTabBarController
        self.countryName = String(describing: tabBar.userInputValue)
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        let tabBar = tabBarController as! BaseTabBarController
        tabBar.userInputValue = userInput.text ?? ""
    }
    @IBAction func countryButton(_ sender: UIButton) {
        if let text = userInput.text {
            print("User Input: \(text)")
            fetchCountryInfo(requestedCountry: text)
            
            
            
        } else {
            print("User Input is empty")
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCountryInfo" {
            print("Preparing for segue")
            
            if let destinationVC = segue.destination as? CountryInfoViewController {
                // Pass data to the destination view controller if needed
                destinationVC.countryName = userInput.text
                destinationVC.languageValues = languageValues
                destinationVC.currencySymbol = currencySymbol
                destinationVC.currencyName = currencyName
                destinationVC.capital = capital?.joined(separator: ", ")
                destinationVC.countryOfficialName = countryOfficialName
                destinationVC.countryFlag = countryFlag
                destinationVC.countryCoatOfArms = countryCoatOfArms
                destinationVC.area = area
                destinationVC.population = population
                destinationVC.startOfWeek = startOfWeek
                destinationVC.timezones = timezones
                destinationVC.continents = continents
                destinationVC.mapURL = mapURL
            }
        
        }
        
        
    }
    
   
    
    func fetchCountryInfo(requestedCountry: String) {
        var urlString = "https://restcountries.com/v3.1/translation/" + requestedCountry
        print("url", urlString)
        if let url = URL(string: urlString){
            
            let session = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let error = error {
                    print("❌ Error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("❌ Data is NIL")
                    return
                }
                
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    
                    if let firstCountry = countries.first {
                        // Accessing the currencies dictionary
                        let currencies = firstCountry.currencies
                        self?.capital = firstCountry.capital
                        print("✅Capital: \(self?.capital)")
                        
                        DispatchQueue.main.async {
                            
                            self?.continents = firstCountry.continents
                            print("✅Continent: \(self?.continents)")
                            
                            self?.population = firstCountry.population
                            print("✅Population: \(self?.population)")
                            
                            self?.timezones = firstCountry.timezones
                            print("✅Time Zone: \(self?.timezones)")
                            
                            self?.area = firstCountry.self.area
                            print("✅Area: \(self?.area)")
                            
                            self?.startOfWeek = firstCountry.startOfWeek
                            print("✅Start of Week: \(self?.startOfWeek)")
                            
                            self?.countryFlag = firstCountry.flags.png
                            print("✅countryFlag: \(self?.countryFlag)")
                            
                            self?.mapURL = firstCountry.maps.openStreetMaps
                            print("✅countryFlag: \(self?.mapURL)")
                            
                            self?.countryCoatOfArms = firstCountry.coatOfArms.png
                            print("✅countryCoatOfArms: \(self?.countryCoatOfArms)")
                            //                        self?.languageValues = Array(firstCountry.languages.values)
                            if let firstCountryLanguages = firstCountry.languages as? [String: String] {
                                self?.languageValues = [:]
                                
                                for (key, value) in firstCountryLanguages {
                                    self?.languageValues?[key] = [value]
                                }
                            }
                            print("✅Languages: \(self?.languageValues)")
                            
                            // Getting the first (and possibly only) currency code
                            if let firstCurrencyCode = currencies.keys.first {
                                print("✅Currency Code: \(firstCurrencyCode)")
                                
                                // Access the properties of the country as needed
                                self?.countryOfficialName = firstCountry.name.official
                                
                                // Accessing currency information using getCurrencyInfo with firstCurrencyCode
                                if let currencyInfo = firstCountry.getCurrencyInfo(for: firstCurrencyCode) {
                                    self?.currencyName = currencyInfo.name
                                    self?.currencySymbol = currencyInfo.symbol
                                    print("✅Currency Name for \(firstCurrencyCode): \(self?.currencyName), Symbol: \(self?.currencySymbol)")
                                } else {
                                    print("Currency not found for \(firstCurrencyCode)")
                                }
                                
                                print("✅Country Name: \(self?.countryOfficialName)")
                                
                                // Now perform the segue after data is fetched
                                self?.performSegue(withIdentifier: "ShowCountryInfo", sender: self)
                            } else {
                                print("No currencies found")
                            }
                        }
                        
                    } else {
                        print("No countries found")
                    }
                    
                    // Update your view controller properties or UI elements accordingly
                    
                } catch {
                    print("❌ Error decoding JSON: \(error.localizedDescription)")
                }
            }
            
            session.resume()
        }
    }
    
    
    
}

// Extension for UIImage GIF support
import UIKit

extension UIImage {
    class func gif(data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }

        var images: [UIImage] = []

        let frameCount = CGImageSourceGetCount(source)
        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                let uiImage = UIImage(cgImage: cgImage)
                images.append(uiImage)
            }
        }

        // Create animated image from the array of frames
        return UIImage.animatedImage(with: images, duration: Double(frameCount) / 10.0) // Adjust the duration as needed
    }
}


