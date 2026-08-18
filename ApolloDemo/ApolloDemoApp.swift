//
//  ApolloDemoApp.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 7/29/26.
//

import SwiftUI

@main
struct ApolloDemoApp: App {
    var body: some Scene {
        WindowGroup {
            let networking = Networking()
            let config = MexicoConfiguration(environment: .staging)
            let service = CountriesService(config: config, networking: networking)

            let dataSource = CountriesDataSource(service: service)
            let viewModel = CountriesViewModel(dataSource: dataSource)
            let countryDetailsDataSource = CountryDetailDataSource(service: service)
            CountriesListView(
                viewModel: viewModel,
                makeDetailsViewModel: {
                    CountryDetailsViewModel(
                        dataSource: countryDetailsDataSource
                    )
                }
            )
        }
    }
}
