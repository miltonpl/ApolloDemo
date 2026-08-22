//
//  CountriesViewModel.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/4/26.
//

import Foundation
import Observation

@Observable
final class CountriesViewModel {
    private let dataSource: CountriesDataSourceAPI
    var countries: [CountryItem] = []
    var errorMessage: String? = nil
    var isLoading: Bool = false

    init(dataSource: CountriesDataSource) {
        self.dataSource = dataSource
    }

    @MainActor
    func loadCountries() async {
        isLoading = true
        errorMessage = nil
        let result = await Result {
            try await dataSource.fetchCountries()
        }
        switch result {
        case .success(let items):
            countries = items
        case .failure(let error):
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
