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
                HeadlinesView(articles: viewModel.articles!).onReceive(NotificationCenter.default.publisher(
                    for: UIApplication.willEnterForegroundNotification)) { _ in
                        viewModel.refreshIfNeeded()
                    }
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
        guard let country = viewModel.getCountryCode() else {
            return
        }
        viewModel.fetchHeadlines(country: country)
    }
    
}
