//
//  CountryDetailsViewManager.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/21/26.
//

import SwiftUI

protocol CountryDetailsViewFactory {
    @MainActor
    func make(for code: String) -> CountryDetailsView
}

final class CountryDetailsViewManager: CountryDetailsViewFactory {
    typealias MakeFunc = @MainActor @Sendable (String) -> CountryDetailsView
    private let makeClosure: MakeFunc

    init(make: @escaping MakeFunc) {
        self.makeClosure = make
    }

    @MainActor
    func make(for code: String) -> CountryDetailsView {
        self.makeClosure(code)
    }

    @MainActor
    static func make(code: String, viewModel: CountryDetailsViewModel) -> CountryDetailsView {
        return CountryDetailsView(viewModel: viewModel, countryCode: code)
    }

    static func live(_ services: CountriesServices) -> CountryDetailsViewFactory {
        let dataSource = CountryDetailDataSource(service: services)
        return CountryDetailsViewManager { code in
            let viewModel = CountryDetailsViewModel(dataSource: dataSource)
            return self.make(code: code, viewModel: viewModel)
        }
    }
}
