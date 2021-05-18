//
//  Headlines.swift
//  Newsly
//
//  Created by Kislay Kishore on 04/05/21.
//

import SwiftUI

struct HeadlinesView: View {
    
    let articles: [Article]
    
    var body: some View {
        NavigationView {
            List(articles.indices) { i in
                ZStack {
                    NavigationLink(destination: WebViewPage(url: articles[i].url)) {
                        EmptyView()
                    }
                    ArticleView(article: articles[i], first: i == 0)
                }
            }.navigationBarTitle(LocalizedStringKey("HomeTitle"))
        }
    }
}

struct ArticleView: View {
    
    let article: Article
    var first = false
    
    var body: some View {
        HStack(alignment: .top){
            VStack(alignment: .leading, content: {
                if first && article.urlToImage != nil {
                    RemoteImageView(imgUrl: article.urlToImage!)
                        .frame(maxWidth: .infinity).scaledToFit()
                        .clipped().cornerRadius(4.0)
                }
                Text(article.title).font(.system(size: 12))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                Spacer().frame(height: 4)
                if article.description != nil {
                    Text(article.description!).font(.system(size: 10))
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                }
                Spacer()
                HStack(content: {
                    Text(article.author ?? NSLocalizedString("NA", comment: ""))
                        .font(.system(size: 8))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                    Text(Utils.isoToSinceTime(isoTime: article.publishedAt))
                        .font(.system(size: 8))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                })
            }).padding(.horizontal, 2)
            if article.urlToImage != nil && !first {
                RemoteImageView(imgUrl: article.urlToImage!)
                    .frame(width: 80, height: 80)
                    .scaledToFit().clipped().cornerRadius(4.0)
            }
        }
    }
}

//struct Headlines_Previews: PreviewProvider {
//    static var previews: some View {
//        Headlines()
//    }
//}
