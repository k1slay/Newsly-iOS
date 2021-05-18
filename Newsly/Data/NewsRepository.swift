//
//  NewsRepository.swift
//  Newsly
//
//  Created by Kislay Kishore on 04/05/21.
//

import Foundation


struct NewsRepository {
    
    let remoteDataSource: RemoteDataSourceImpl
    
    func fetchArticles(country: String, completion: @escaping (ApiResult?) -> Void) {
        remoteDataSource.fetchArticles(country: country, completion: completion)
    }
    
}
