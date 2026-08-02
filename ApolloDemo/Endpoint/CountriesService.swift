//
//  CountriesService.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/1/26.
//

import Foundation
import Apollo
import CountriesAPI

class CountriesService {
    let client: ApolloClient
    init(url: URL) {
//        client = ApolloClient(
//            networkTransport: RequestChainNetworkTransport(
//                interceptorProvider: URLSession.shared,
//                endpointURL: endpointURL
//            )
//        )
        client = ApolloClient(url: url)

    }

    func fetch() async throws -> GraphQLResponse<CountriesQuery>{
        let query = CountriesQuery()
//        let result = client.fetch(query: query)
//        dump(result)
        let client = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
        return try await client.fetch(query: query, cachePolicy: .cacheFirst)
    }
}
