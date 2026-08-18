//
//  CountryDetailItem.swift
//  ApolloDemo
//
//  Created by Milton Palaguachi on 8/12/26.
//

import Foundation

struct CountryDetailItem: Identifiable, Hashable {
    let id: String // ISO country code
    let name: String
    let nativeName: String
    let capital: String
    let emoji: String
    let phoneCode: String
    let currency: String
    let languages: [LanguageItem]
    let states: [StateItem]
    
    struct LanguageItem: Identifiable, Hashable {
        let id: String // e.g., "pt", "en"
        let name: String
        let nativeName: String
    }
    
    struct StateItem: Identifiable, Hashable {
        let id: String?
        let name: String
    }
}
