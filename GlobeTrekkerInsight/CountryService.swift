//
//  CountryService.swift
//  GlobeTrekkerInsight
//
//  Created by Yasaman Emami on 11/14/23.
//

import UIKit

protocol CountryServiceDelegate: AnyObject {
    func didFetchCountryInfo(countryInfo: Country)
}

class CountryService: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    let viewController = ViewController()
    weak var delegate: CountryServiceDelegate?
    func fetchCountryInfo(requestedCountry: String) {
        var urlString = "https://restcountries.com/v3.1/translation/" + requestedCountry
        let url = URL(string: urlString)!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
                print("❌ Response error: \(String(describing: response))")
                return
            }
            
            guard let data = data else {
                print("❌ Data is NIL")
                return
            }
            
            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)
                
                DispatchQueue.main.async { [weak self] in
                    if let firstCountry = countries.first {
                        // Accessing the currencies dictionary
                        
                        let currencies = firstCountry.currencies
                        let capital = firstCountry.capital
                        print("✅Capital: \(capital)")
                        if (self?) != nil viewController.countryNameLabel, !capital.isEmpty {
                            let firstCharacter = capital[capital.index(capital.startIndex, offsetBy: 0)]
                            DispatchQueue.main.async { [self] in
                                self.viewController.countryNameLabel.text = String(firstCharacter)
                            }
                        } else {
                            // Handle the case where countryNameLabel is nil or capital is an empty string
                            DispatchQueue.main.async {
                                self?viewController.countryNameLabel?.text = "No capital available"
                            }
                        }
                        let continent = firstCountry.continents
                        print("✅Continent: \(continent)")
                        let population = firstCountry.population
                        print("✅Population: \(population)")
                        let timeZone = firstCountry.timezones
                        print("✅Time Zone: \(timeZone)")
                        let languageValues = Array(firstCountry.languages.values)
                        print("✅Languages: \(languageValues)")
                        // Getting the first (and possibly only) currency code
                        if let firstCurrencyCode = currencies.keys.first {
                            print("✅Currency Code: \(firstCurrencyCode)")
                            
                            // Access the properties of the country as needed
                            let countryName = firstCountry.name.common
                            
                            // Accessing currency information using getCurrencyInfo with firstCurrencyCode
                            if let currencyInfo = firstCountry.getCurrencyInfo(for: firstCurrencyCode) {
                                let currencyName = currencyInfo.name
                                let currencySymbol = currencyInfo.symbol
                                print("✅Currency Name for \(firstCurrencyCode): \(currencyName), Symbol: \(currencySymbol)")
                            } else {
                                print("Currency not found for \(firstCurrencyCode)")
                            }
                            
                            print("✅Country Name: \(countryName)")
                        } else {
                            print("No currencies found")
                        }
                    } else {
                        print("No countries found")
                    }
                    
                    
                    
                    // Update your view controller properties or UI elements accordingly
                }
                
                
                
                
            } catch {
                print("❌ Error decoding JSON: \(error.localizedDescription)")
            }
        }
        session.resume()
        
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
