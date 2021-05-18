//
//  NewslyApp.swift
//  Newsly
//
//  Created by Kislay Kishore on 15/04/21.
//

import SwiftUI

@main
struct NewslyApp: App {
    
    @StateObject var viewModel = HeadlinesViewModel()
    
    var body: some Scene {
        WindowGroup {
            if viewModel.articles != nil {
                HeadlinesView(articles: viewModel.articles!)
            } else if viewModel.isError {
                ErrorView(errorMessage: viewModel.errorMessage, onRetryClick: {
                    fetchHeadlines()
                })
            } else {
                LoadingView().onAppear(perform: fetchHeadlines)
            }
        }
    }
    
    private func fetchHeadlines() {
        let locale = Locale.current
        guard let country = locale.regionCode else {
            print("Error getting country code")
            viewModel.isError = true
            return
        }
        viewModel.fetchHeadlines(country: country)
    }

}
