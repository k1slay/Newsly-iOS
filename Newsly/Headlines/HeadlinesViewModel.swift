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
    private var lastFetch: Double = 0
    
    let repository: NewsRepository
    
    init() {
        let remoteDataSource = RemoteDataSourceImpl()
        repository = NewsRepository(remoteDataSource: remoteDataSource)
    }
    
    func refreshIfNeeded() {
        if ((Date().timeIntervalSince1970 - lastFetch) > 60 * 30) {
            self.isError = false
            self.articles = nil
        }
    }
    
    func fetchHeadlines(country: String) {
        if self.isError {
            self.isError = false
        }
        self.articles = nil
        repository.fetchArticles(country: country) { apiResult in
            guard let articles = apiResult?.articles else {
                DispatchQueue.main.async {
                    self.errorMessage = apiResult?.errorMessage
                    self.isError = true
                }
                return
            }
            DispatchQueue.main.async {
                self.lastFetch = Date().timeIntervalSince1970
                self.articles = articles
            }
        }
    }
    
    func getCountryCode() -> String? {
        let locale = Locale.current
        guard let country = locale.regionCode else {
            print("Error getting country code")
            isError = true
            return nil
        }
        return country
    }
    
}
