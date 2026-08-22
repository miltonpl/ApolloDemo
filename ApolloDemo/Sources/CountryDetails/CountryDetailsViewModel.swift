//
//  CountryDetailsViewModel.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/12/26.
//


import Foundation
import Observation

@Observable
final class CountryDetailsViewModel {
    private let dataSource: CountryDetailDataSourceAPI
    var countryDetails: CountryDetailItem?
    var errorMessage: String? = nil
    var isLoading: Bool = false

    init(dataSource: CountryDetailDataSourceAPI) {
        self.dataSource = dataSource
    }

    @MainActor
    func fetchDetails(code: String) async {
        isLoading = true
        errorMessage = nil
        countryDetails = nil

        let result = await Result {
            try await dataSource.fetchDetails(for: code)
        }

        switch result {
        case .success(let item):
            countryDetails = item
        case .failure(let error):
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
