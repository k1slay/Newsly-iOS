//
//  Article.swift
//  Newsly
//
//  Created by Kislay Kishore on 29/04/21.
//

import Foundation

struct Article: Decodable {
    let title: String
    let description: String?
    let author: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    let source: Source
}

struct Source: Decodable {
    let id: String?
    let name: String
}
