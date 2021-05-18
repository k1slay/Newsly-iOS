//
//  HeadlinesViewModel.swift
//  Newsly
//
//  Created by Kislay Kishore on 04/05/21.
//

import Foundation

class HeadlinesViewModel: ObservableObject {
    
    @Published var articles: [Article]? = nil
    @Published var isError: Bool = false
    var errorMessage: String? = nil
    
    let repository: NewsRepository
    
    init() {
        let remoteDataSource = RemoteDataSourceImpl()
        repository = NewsRepository(remoteDataSource: remoteDataSource)
    }
    
    func fetchHeadlines(country: String) {
        if self.isError {
            self.isError = false
        }
        repository.fetchArticles(country: country) { apiResult in
            guard let articles = apiResult?.articles else {
                DispatchQueue.main.async {
                    self.errorMessage = apiResult?.errorMessage
                    self.isError = true
                }
                return
            }
            DispatchQueue.main.async {
                self.articles = articles
            }
        }
    }
    
}
