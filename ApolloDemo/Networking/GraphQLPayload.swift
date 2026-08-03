//
//  GraphQLPayload.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/2/26.
//

@_spi(Unsafe) import ApolloAPI // Required to access the internal variable data maps
import Foundation

// Standard top-level GraphQL JSON layout
struct GraphQLPayload<Query: GraphQLQuery>: Encodable {
    let query: Query
    enum CodingKeys: String, CodingKey {
        case query
        case variables
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        // 1. Pull the raw multi-line schema document string
        guard let queryString = Query.operationDocument.definition?.queryDocument else {
            let context = EncodingError.Context(codingPath: [CodingKeys.query], debugDescription: "Missing Query Document")
            throw EncodingError.invalidValue(Query.self, context)
        }
        try container.encode(queryString, forKey: .query)
        
        // 2. FIXED: Access _jsonEncodableValue directly without calling the internal _jsonValue property
        if let variablesContainer = query.__variables,
           let jsonDictionary = variablesContainer._jsonEncodableValue as? [String: Any] {
            // Directly hand over the native Swift dictionary to our Encodable wrapper
            try container.encode(AnyEncodable(value: jsonDictionary), forKey: .variables)
        }
    }
}

// MARK: - Type Erasure Helper for Variable Primitives
struct AnyEncodable: Encodable {
    let value: Any
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch value {
        case let string as String: try container.encode(string)
        case let int as Int: try container.encode(int)
        case let bool as Bool: try container.encode(bool)
        case let double as Double: try container.encode(double)
        case let dict as [String: Any]: try container.encode(dict.mapValues { AnyEncodable(value: $0) })
        case let array as [Any]: try container.encode(array.map { AnyEncodable(value: $0) })
        case is NSNull: try container.encodeNil()
        default:
            let context = EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Unsupported Type")
            throw EncodingError.invalidValue(value, context)
        }
    }
}
