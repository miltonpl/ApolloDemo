//
//  URLRequest+Extensions.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/3/26.
//

import Foundation

extension URLRequest {
    static func post(url: URL, headers: [String: String] = [:], httpBody: Data?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        request.httpBody = httpBody
        return request
    }
}
