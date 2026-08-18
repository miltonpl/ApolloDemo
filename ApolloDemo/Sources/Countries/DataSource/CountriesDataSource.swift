//
//  CountriesDataSource.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/3/26.
//

import Apollo
import CountriesAPI
import Foundation

protocol CountriesDataSourceAPI {
    func getCountries() async throws -> [CountryItem]
}

final class CountriesDataSource: CountriesDataSourceAPI {
    private let service: CountriesService

    init(service: CountriesService) {
        self.service = service
    }

    func getCountries() async throws -> [CountryItem] {
        let query = CountriesQuery()
        let response = try await service.fetch(query: query)
        if let errors = response.errors, !errors.isEmpty {
            let message = errors.map { $0.message ?? "" }.joined(separator: ",")
            throw NetworkError.message(message)
        }

        guard let countries = response.data?.countries else {
            return []
        }

        return countries.map { country in
            CountryItem(
                id: country.code,
                name: country.name,
                emoji: country.emoji
            )
        }
    }
}
