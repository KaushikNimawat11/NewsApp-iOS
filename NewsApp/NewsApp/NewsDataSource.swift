//
//  NewsDataSource.swift
//  NewsApp
//
//  Created by Licious on 22/03/22.
//
import Foundation

class NewsDataSource {
    func getNewsData(completion: @escaping ([Article])->()) {
        let url = "https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=ae8c52f5e7ff43489b4cdfd60ced146d"
        guard let validUrl = URL(string: url) else {
            print("invalid url")
            return
        }
        let task = URLSession.shared.dataTask(with: validUrl, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
                // print(result!)
            }
            catch {
                print("failed to convert")
            }
            guard let json = result else {
                return
            }
            completion(json.articles)
        })
        task.resume()
    }
}
