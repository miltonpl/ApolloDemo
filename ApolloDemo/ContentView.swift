//
//  ContentView.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 7/29/26.
//

import Apollo
import CountriesAPI
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .task {
            do {
                let services = CountriesService(
                    config: MexicoConfiguration(
                    environment: .staging),
                    networking: Networking()
                )
                let result = try await services.fetch(query: CountriesQuery())
                guard let countries = result.data?.countries else {
                    dump("No counties")
                    return
                }
                for country in countries {
                    dump(country.name)
                }
                
            } catch {
                dump(error)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
