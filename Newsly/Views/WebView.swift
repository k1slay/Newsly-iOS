//
//  WebView.swift
//  Newsly
//
//  Created by Kislay Kishore on 08/05/21.
//

import WebKit
import SwiftUI

final class WebView: UIViewRepresentable {
    
    private let viewModel: WebViewModel
    let request: URLRequest
    
    init(url: String, viewModel: WebViewModel) {
        let url = URL(string: url)
        self.request = URLRequest(url: url!)
        self.viewModel = viewModel
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        let view = WKWebView()
        view.load(request)
        view.navigationDelegate = context.coordinator
        return view
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: self.viewModel)
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
}


class Coordinator: NSObject, WKNavigationDelegate {
    
    private let viewModel: WebViewModel
    private var webView: WKWebView? = nil
    private let progressKey = "estimatedProgress"
    
    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewModel.isLoading = false
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.webView = webView
        webView.addObserver(self, forKeyPath: progressKey, options: .new, context: nil)
        viewModel.isLoading = true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == progressKey {
            guard let currentProgress = webView?.estimatedProgress else {
                return
            }
            viewModel.progress = currentProgress
        }
    }
    
}

struct WebViewPage: View {
    
    let url: String
    @ObservedObject private var viewModel = WebViewModel()
    
    init(url: String) {
        self.url = url
    }
    
    var body: some View {
        ZStack(alignment: .top, content: {
            WebView(url: url, viewModel: viewModel)
            if viewModel.isLoading {
                ProgressView(value: viewModel.progress)
            }
        })
    }
    
}

class WebViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var progress = 0.0
}

//struct WebView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebView()
//    }
//}
