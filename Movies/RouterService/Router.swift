//
//  Router.swift
//  Movies
//
//  Created by Faheem Rahman on 15/06/22.
//

import Foundation


class Router :  NSObject {
    
    private let apiKey = "b9bd48a6"
    private let sourcesURL = URL(string: "http://www.omdbapi.com")!
    
    func getAllMovies_API( searchKey : String?, completion : @escaping (Movie) -> ()){
        // To show results for the first time. No response is coming if search text is empty.
        var searchText = "marvel"
        if searchKey != nil && searchKey != "" {
            searchText = searchKey!
        }
        let params = ["apikey" : apiKey,
            "s" : searchText,
             "type" : "movie"
        ]
        var components = URLComponents(string: "http://www.omdbapi.com")!
            components.queryItems = params.map { (key, value) in
                URLQueryItem(name: key, value: value)
            }
        let request = URLRequest(url: components.url!)
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                do {
                let productsData = try jsonDecoder.decode(Movie.self, from: data)
                    completion(productsData)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}

