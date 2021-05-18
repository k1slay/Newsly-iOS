//
//  RemoteDataSource.swift
//  Newsly
//
//  Created by Kislay Kishore on 01/05/21.
//

import Foundation

protocol RemoteDataSource {
    
    func fetchArticles(country: String, completion: @escaping (ApiResult?) -> Void)
    
}

struct RemoteDataSourceImpl: RemoteDataSource {
    
    func fetchArticles(country: String, completion: @escaping (ApiResult?) -> Void) {
        var urlComponents = URLComponents(string: "https://newsapi.org/v2/top-headlines")
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "apiKey", value: Constants.API_KEY))
        queryItems.append(URLQueryItem(name: "country", value: country))
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else {
            completion(nil)
            return
        }
        let urlSession = URLSession(configuration: .default)
        urlSession.dataTask(with: url) { data, response, error in
            guard let articlesData = data else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            try? completion(decoder.decode(ApiResult.self, from: articlesData))
        }.resume()
    }
    
}
