//
//  RemoteImageView.swift
//  Newsly
//
//  Created by Kislay Kishore on 05/05/21.
//

import SwiftUI

struct RemoteImageView: View {
    
    @ObservedObject private var loader: ImageLoader
    
    init(imgUrl: String) {
        loader = ImageLoader(imgUrl: imgUrl)
    }
    
    var body: some View {
        if loader.imgData == nil {
            Image("placeholder")
        } else {
            let uiImage = UIImage(data: loader.imgData!)
            Image(uiImage: uiImage!)
                .resizable()
                .scaledToFill()
        }
    }
    
}

//struct RemoteImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        RemoteImageView()
//    }
//}
