//
//  CountriesService.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/1/26.
//

import Foundation
import Apollo
import CountriesAPI

protocol CountriesServices: Sendable {
    func fetch<Q: GraphQLQuery>(query: Q) async throws -> GraphQLResponse<Q>
}

class CountriesManager: CountriesServices {
    let networking: Networking
    let graphqlURL: URL

    init(config: AppConfiguration, networking: Networking) {
        self.graphqlURL = config.graphqlURL
        self.networking = networking
    }

    func fetch<Q: GraphQLQuery>(query: Q) async throws -> GraphQLResponse<Q> {
        let payload = GraphQLPayload(query: query)
        let encoder = JSONEncoder()
        let bodyData = try? encoder.encode(payload)
        let request = URLRequest.post(url: graphqlURL, httpBody: bodyData)
        return try await networking.executeQuery(query, request: request)
        
    }
}
