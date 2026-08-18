//
//  CountryDetailsView.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/17/26.
//

import SwiftUI

struct CountryDetailsView: View {
    @State private var viewModel: CountryDetailsViewModel
    let countryCode: String

    init(viewModel: CountryDetailsViewModel, countryCode: String) {
        _viewModel = State(initialValue: viewModel)
        self.countryCode = countryCode
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Fetching details...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let errorMessage = viewModel.errorMessage {
                    ContentUnavailableView(
                        "Failed to Load",
                        systemImage: "exclamationmark.triangle",
                        description: Text(errorMessage)
                    )
            } else if let countryDetails = viewModel.countryDetails {
                countryContent(countryDetails)
            } else {
                ContentUnavailableView(
                    "No data Available",
                                       systemImage: "globe",
                    description: Text("Could not find details for code \(countryCode)"))
            }
        }
        .navigationTitle(viewModel.countryDetails?.name ?? "Country Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchDetails(code: countryCode)
        }
    }
// MARK: - Main Content Layout

    @ViewBuilder
    private func countryContent(_ country: CountryDetailItem) -> some View {
        ScrollView {
            VStack(spacing: 20) {
                // Hero Flag & Name Header
                headerView(country)

                // Key Quick Facts Grid
                quickFactsGrid(country)

                // Languages Section
                if !country.languages.isEmpty {
                    languagesSection(country.languages)
                }

                // States / Provinces List
                if !country.states.isEmpty {
                    statesSection(country.states)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }

    // MARK: - Header Component

    private func headerView(_ country: CountryDetailItem) -> some View {
        VStack(spacing: 8) {
            Text(country.emoji)
                .font(.system(size: 80))
                .shadow(radius: 2)

            Text(country.name)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)

            Text(country.nativeName)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - Quick Facts Cards

    private func quickFactsGrid(_ country: CountryDetailItem) -> some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                FactCard(title: "Capital", value: country.capital, icon: "building.2.fill")
                FactCard(title: "Phone Code", value: country.phoneCode, icon: "phone.fill")
            }
            HStack(spacing: 12) {
                FactCard(title: "Currency", value: country.currency, icon: "banknote.fill")
                FactCard(title: "ISO Code", value: country.id, icon: "globe.americas.fill")
            }
        }
    }

    // MARK: - Languages Section

    private func languagesSection(_ languages: [CountryDetailItem.LanguageItem]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Languages Spoken", systemImage: "bubble.left.and.bubble.right.fill")
                .font(.headline)
                .foregroundStyle(.secondary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(languages) { language in
                        VStack(alignment: .leading, spacing: 2) {
                            Text(language.name)
                                .font(.body)
                                .fontWeight(.medium)
                            
                            if language.name != language.nativeName {
                                Text(language.nativeName)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.accentColor.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
        .padding()
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - States Section

    private func statesSection(_ states: [CountryDetailItem.StateItem]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("States & Regions (\(states.count))", systemImage: "map.fill")
                .font(.headline)
                .foregroundStyle(.secondary)

            LazyVStack(spacing: 8) {
                ForEach(states, id: \.self) { state in
                    HStack {
                        Text(state.name)
                            .font(.body)
                        Spacer()
                        if let code = state.id {
                            Text(code)
                                .font(.caption)
                                .monospaced()
                                .foregroundStyle(.secondary)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color(uiColor: .tertiarySystemFill))
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                        }
                    }
                    if state != states.last {
                        Divider()
                    }
                }
            }
        }
        .padding()
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Helper Reusable Fact Card Component

private struct FactCard: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(Color.accentColor)
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Text(value)
                .font(.headline)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

//#Preview {
//    CountryDetailsView()
//}
