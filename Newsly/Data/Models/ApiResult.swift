//
//  ApiResult.swift
//  Newsly
//
//  Created by Kislay Kishore on 29/04/21.
//

import Foundation

struct ApiResult {
    let status: String?
    let totalResults: Int?
    let articles: Array<Article>?
    let errorCode: String?
    let errorMessage: String?
}

extension ApiResult: Decodable {
    enum CodingKeys: String, CodingKey {
        case status, articles, totalResults
        case errorCode = "code"
        case errorMessage = "message"
    }
}
