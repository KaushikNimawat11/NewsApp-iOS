//
//  DemoTableViewCell.swift
//  NewsApp
//
//  Created by Licious on 22/03/22.
//

import UIKit

protocol DemoTableViewCellDelegate : AnyObject {
    func buttonTapped(title: String)
}
class DemoTableViewCell: UITableViewCell{

    @IBOutlet var label1: UILabel!
    @IBOutlet var imagecol: UIImageView!
    
    weak var delegate: DemoTableViewCellDelegate?
    
    var process: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
  
    @IBAction func buttonAction(_ sender: Any) {
        delegate?.buttonTapped(title: label1.text ?? "")
    }
    func setData(article: Article) {
        label1.text = article.title
        imagecol.image = UIImage(named: "LoadingImage")
        let image = article.urlToImage
        if let image1 = image {
            if (UrlDict.share.urls[image1] != nil) {
                print("using catch")
                imagecol.image = UrlDict.share.urls[image1]
            }
            else {
                downloaded(from: image1)
            }
        }
        else {
            imagecol.image = UIImage(named: "NoImage")
        }
    }
   
    func downloaded(from url: URL) {
        
        process = URLSession.shared.dataTask(with: url) { [self] data, response, error in
           
            guard
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                //self.imagecol.image = UIImage(named: "NoImage")
                return
            }
            
            UrlDict.share.urls[url.absoluteString] = image
            DispatchQueue.main.async() { [weak self] in
                self?.imagecol.image = image
            }
        }
        process?.resume()
    }
    
    func downloaded(from link: String) {
        guard let url = URL(string: link) else {
            return
        }
        downloaded(from: url)
    }
}



