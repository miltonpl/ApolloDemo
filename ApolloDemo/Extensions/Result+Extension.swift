//
//  Result+Extension.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/21/26.
//

import Foundation

extension Result where Failure == Error {
    /// Initializes a Result by evaluating an async throwing closure.
    init(catching body: () async throws -> Success) async {
        do {
            let success = try await body()
            self = .success(success)
        } catch {
            self = .failure(error)
        }
    }
}
