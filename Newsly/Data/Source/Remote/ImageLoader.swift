//
//  ImageLoader.swift
//  Newsly
//
//  Created by Kislay Kishore on 05/05/21.
//

import Foundation

class ImageLoader: ObservableObject {
    
    private let imgUrl: String
    
    init(imgUrl: String) {
        self.imgUrl = imgUrl
        fetchImage()
    }
    
    @Published var imgData: Data? = nil
    
    func fetchImage() {
        let cache = URLCache.shared
        guard let url = URL(string: imgUrl) else { return }
        let request = URLRequest(
            url: url,
            cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad,
            timeoutInterval: 30.0
        )
        if let data = cache.cachedResponse(for: request)?.data {
            self.imgData = data
        } else {
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    self.imgData = data
                }
            }.resume()
        }
    }
    
}
