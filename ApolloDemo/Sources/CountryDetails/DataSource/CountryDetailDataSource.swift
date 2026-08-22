//
//  CountryDetailDataSource.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/12/26.
//

import Apollo
import CountriesAPI
import Foundation

protocol CountryDetailDataSourceAPI: Sendable {
    func fetchDetails(for countryCode: String) async throws -> CountryDetailItem?
}

final actor CountryDetailDataSource: CountryDetailDataSourceAPI {
    private let service: CountriesServices

    init(service: CountriesServices) {
        self.service = service
    }

    func fetchDetails(for countryCode: String) async throws -> CountryDetailItem? {
        let query = CountryDetailsQuery(code: countryCode)
        let response = try await service.fetch(query: query)
        if let errors = response.errors, !errors.isEmpty {
            let message = errors.map { $0.message ?? "" }.joined(separator: ",")
            throw NetworkError.message(message)
        }

        guard let country = response.data?.country else {
            return nil
        }
        return CountryDetailItem(
            id: countryCode,
            name: country.name,
            nativeName: country.native,
            capital: country.capital ?? "",
            emoji: country.emoji,
            phoneCode: country.phone,
            currency: country.currency ?? "",
            languages: country.languages.map { language in
                CountryDetailItem.LanguageItem(
                    id: language.code,
                    name: language.name,
                    nativeName: language.native
                )
            },
            states: country.states.map { state in
                CountryDetailItem.StateItem(
                    id: state.code,
                    name: state.name
                )
            }
        )
    }
}
