//
//  CountriesView.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/4/26.
//

import SwiftUI

struct CountriesListView: View {
    @State private var viewModel: CountriesViewModel
    private let detailsFactory: CountryDetailsViewFactory

    init(
        viewModel: CountriesViewModel,
        detailsFactory: CountryDetailsViewFactory
    ) {
        _viewModel = State(initialValue: viewModel)
        self.detailsFactory = detailsFactory
    }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Fetching countries...")
                } else if let error = viewModel.errorMessage {
                    ContentUnavailableView {
                        Label(
                            "Failed to load data",
                            systemImage: "exclamationmark.triangle"
                        )
                    } description: {
                        Text(error)
                    } actions: {
                        Button("Retry") {
                            Task { await viewModel.loadCountries() }
                        }
                    }
                } else {
                    List(viewModel.countries) { country in
                        NavigationLink(value: country.id) {
                            HStack(spacing: 16) {
                                Text(country.emoji)
                                    .font(.largeTitle)
                                    .frame(width: 44, height: 44)
                                    .background(Color(.systemGroupedBackground))
                                    .clipShape(Circle())
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(country.name)
                                        .font(.headline)
                                    Text("Code: \(country.id)")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .navigationDestination(for: String.self, destination: { countryCode in
                        detailsFactory.make(for: countryCode)
                    })
                    .overlay {
                        if viewModel.countries.isEmpty {
                            ContentUnavailableView("No Countries Found", systemImage: "globe")
                        }
                    }
                }
            }.navigationTitle("Global Countries")
        }
        .task {
            await viewModel.loadCountries()
        }
    }
}

//#Preview {
//    CountriesView()
//}
