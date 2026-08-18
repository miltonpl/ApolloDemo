//
//  Networking.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/2/26.
//

import Apollo
@_spi(Unsafe) import ApolloAPI
import Combine
import Foundation

final class Networking {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func requestData(request: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: request)
    }
}

extension Networking {
    func executeQuery<Query: GraphQLQuery>(
        _ query: Query,
        request: URLRequest
    ) async throws
    -> GraphQLResponse<Query> {

        let (data, response) = try await requestData(request: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.response(response)
        }

        // 1. Initialize the parser object instance
        let parser = JSONResponseParser(
            response: httpResponse,
            operationVariables: query.__variables,
            includeCacheRecords: false
        )

        // 2. Trigger the asynchronous schema serialization execution mapping
        guard let parserResult = try await parser.parse(
            dataChunk: data,
            mergingIncrementalItemsInto: nil as ParsedResult<Query>?
        ) else {
            throw NetworkError.message("Unable to parse")
        }

        return parserResult.result
    }
}

enum NetworkError: Error {
    case message(String)
    case response(URLResponse)
}
