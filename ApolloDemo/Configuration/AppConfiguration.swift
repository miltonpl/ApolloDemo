//
//  AppConfiguration.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/1/26.
//

import Foundation

protocol AppConfiguration {
    var graphqlURL: URL { get }
}

struct MexicoConfiguration: AppConfiguration {
    let environment: Environment

    init(environment: Environment) {
        self.environment = environment
    }

    var graphqlURL: URL {
        switch environment {
        case .production:
            return URL(string: "https://countries.trevorblades.com/")!
        case .staging:
            return URL(string: "https://countries.trevorblades.com/")!
        case .development:
            return URL(string: "https://countries.trevorblades.com/")!
        }
    }
}
