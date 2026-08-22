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
            let service = CountriesManager(config: config, networking: networking)

            let listDataSource = CountriesDataSource(service: service)
            let detailsFactory = CountryDetailsViewManager.live(service)
            CountriesListView(
                viewModel: CountriesViewModel(dataSource: listDataSource),
                detailsFactory: detailsFactory
            )
        }
    }
}
