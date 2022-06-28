//
//  ViewController.swift
//  NewsApp
//
//  Created by Licious on 21/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var newsData = [Article]()
    //var urls: [String:UIImage] = [:]
    let newDataSource = NewsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        newDataSource.getNewsData { data in
            self.newsData = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        tableView.delegate = self
    }
}

struct Response: Codable {
    var status: String?
    var articles: [Article]
}

struct Article: Codable {
    var author: String?
    var title: String
    var description: String?
    var urlToImage: String?
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource, DemoTableViewCellDelegate {
    func buttonTapped(title: String) {
      let alert = UIAlertController(title: "Congratulation", message: title, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok Thanks", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print("Number of rows: \(newsData.count)")
        return newsData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Cell for row at: \(indexPath)")

        var cell: UITableViewCell
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! DemoTableViewCell

        let article = newsData[indexPath.row]
        cell1.setData(article: article)
        
        if indexPath.row == 1 {
            cell1.delegate = self
        }
        
        cell = cell1
        return cell
    }
}

