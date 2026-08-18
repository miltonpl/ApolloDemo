// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

nonisolated public struct CountryDetailsQuery: GraphQLQuery {
  public static let operationName: String = "CountryDetails"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query CountryDetails($code: ID!) { country(code: $code) { __typename name native capital emoji phone currency languages { __typename code name native } states { __typename code name } } }"#
    ))

  public var code: ID

  public init(code: ID) {
    self.code = code
  }

  @_spi(Unsafe) public var __variables: Variables? { ["code": code] }

  nonisolated public struct Data: CountriesAPI.SelectionSet {
    @_spi(Unsafe) public let __data: DataDict
    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { CountriesAPI.Objects.Query }
    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
      .field("country", Country?.self, arguments: ["code": .variable("code")]),
    ] }
    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      CountryDetailsQuery.Data.self
    ] }

    public var country: Country? { __data["country"] }

    /// Country
    ///
    /// Parent Type: `Country`
    nonisolated public struct Country: CountriesAPI.SelectionSet {
      @_spi(Unsafe) public let __data: DataDict
      @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

      @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { CountriesAPI.Objects.Country }
      @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("name", String.self),
        .field("native", String.self),
        .field("capital", String?.self),
        .field("emoji", String.self),
        .field("phone", String.self),
        .field("currency", String?.self),
        .field("languages", [Language].self),
        .field("states", [State].self),
      ] }
      @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        CountryDetailsQuery.Data.Country.self
      ] }

      public var name: String { __data["name"] }
      public var native: String { __data["native"] }
      public var capital: String? { __data["capital"] }
      public var emoji: String { __data["emoji"] }
      public var phone: String { __data["phone"] }
      public var currency: String? { __data["currency"] }
      public var languages: [Language] { __data["languages"] }
      public var states: [State] { __data["states"] }

      /// Country.Language
      ///
      /// Parent Type: `Language`
      nonisolated public struct Language: CountriesAPI.SelectionSet {
        @_spi(Unsafe) public let __data: DataDict
        @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

        @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { CountriesAPI.Objects.Language }
        @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("code", CountriesAPI.ID.self),
          .field("name", String.self),
          .field("native", String.self),
        ] }
        @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          CountryDetailsQuery.Data.Country.Language.self
        ] }

        public var code: CountriesAPI.ID { __data["code"] }
        public var name: String { __data["name"] }
        public var native: String { __data["native"] }
      }

      /// Country.State
      ///
      /// Parent Type: `State`
      nonisolated public struct State: CountriesAPI.SelectionSet {
        @_spi(Unsafe) public let __data: DataDict
        @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

        @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { CountriesAPI.Objects.State }
        @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("code", String?.self),
          .field("name", String.self),
        ] }
        @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          CountryDetailsQuery.Data.Country.State.self
        ] }

        public var code: String? { __data["code"] }
        public var name: String { __data["name"] }
      }
    }
  }
}
