//
//  NewsViewController.swift
//  GlobeTrekkerInsight
//
//  Created by Yasaman Emami on 11/15/23.
//

import UIKit
import Nuke

class NewsViewController: UIViewController,UITableViewDataSource {
    
    
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var newsTableView: UITableView!
    
    var articles: [Article] = []
    var countryName: String?
    var totalResults: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

//        if let text = countryName {
//            
//            fetchNews(requestedCountry: text)
//            
//        } else {
//            print("User Input is empty")
//        }
        let tabBar = tabBarController as! BaseTabBarController
        countryName = String(describing: tabBar.userInputValue)
        newsTableView.dataSource = self
        
        fetchNews(requestedCountry: countryName ?? "us")
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        let tabBar = tabBarController as! BaseTabBarController
        countryName = String(describing: tabBar.userInputValue)
        fetchNews(requestedCountry: countryName ?? "us")
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Assuming you have a navigation controller and your target view controller is "YourViewController"
        if let navigationController = self.navigationController {
            // Instantiate YourViewController from storyboard
            if let navigationVC = navigationController.storyboard?.instantiateViewController(withIdentifier: "YourViewControllerID") as? NewsViewController {
                // Pass data to yourVC
                navigationVC.countryName = self.countryName // Replace "data" with the property you want to pass and "yourData" with the actual data
                
                // Push the view controller onto the navigation stack
                navigationController.pushViewController(navigationVC, animated: true)
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell

        // Get the movie associated table view row
        let article = articles[indexPath.row]

        // Configure the cell (i.e., update UI elements like labels, image views, etc.)

        // Unwrap the optional poster path
        if let posterPath = article.urlToImage,

            // Create a url by appending the poster path to the base url. https://developers.themoviedb.org/3/getting-started/images
           let imageUrl = URL(string: posterPath) {

            // Use the Nuke library's load image function to (async) fetch and load the image from the image URL.
            Nuke.loadImage(with: imageUrl, into: cell.newsImageView)
        }

        // Set the text on the labels
        cell.newsTitle.text = article.title
        cell.newsDescript.text = article.description

        // Return the cell for use in the respective table view row
        return cell
        
    }
    
    func fetchNews(requestedCountry: String) {
        let apiKey = "2595840479dd477fa73db2bf891eda83"
        var urlString = "https://newsapi.org/v2/everything?q=us&apiKey=\(apiKey)"
        
        // Update the URL string with the new 'q' value
        if let apiKeyEncoded = apiKey.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let newQueryEncoded = requestedCountry.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            urlString = "https://newsapi.org/v2/everything?q=\(newQueryEncoded)&apiKey=\(apiKeyEncoded)"
        }
        print("news url",urlString)
        if let url = URL(string: urlString){
            
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
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Received data as string: \(dataString)")
                }
                
                do {
                    let res = try JSONDecoder().decode(NewsResponse.self, from: data)
                    
                    DispatchQueue.main.async { [weak self] in
                        
                        let articles = res.articles
                        self?.articles = articles
                        if let totalResults = res.totalResults{
                            self?.totalResults = totalResults
                        }
                        print("✅ We got \(articles.count) articles!")
                        self?.newsTableView.reloadData()
                        
//                         Using articles directly without optional binding
                        for article in articles {
                            print("✅ article description: \(article.description)")
                        }
                        
                        
                    }
                    
                } catch {
                    print("❌ Error decoding JSON: \(error.localizedDescription)")
                }
            }
            session.resume()
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
