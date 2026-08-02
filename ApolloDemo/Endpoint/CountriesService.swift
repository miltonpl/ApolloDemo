//
//  CountriesService.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/1/26.
//

import Foundation
import Apollo

class CountriesService {
    let client: ApolloClient
    init(url: URL,) {
//        client = ApolloClient(
//            networkTransport: RequestChainNetworkTransport(
//                interceptorProvider: URLSession.shared,
//                endpointURL: endpointURL
//            )
//        )
        client = ApolloClient(url: url)
    }
}
