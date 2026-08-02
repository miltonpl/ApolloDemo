# ApolloDemo



## GraphQL

### Install Apollo iOS CLI

```Generate graph QL queies
./Scripts/generate-graphql.sh


1. 
./apollo-ios-cli init --schema-namespace CountriesAPI --module-type swiftPackage

Step 1: Generate the package
First, make sure the package exists:


Here what ./apollo-ios-cli generate do
Bash: ./apollo-ios-cli generate

CountriesAPI/
├── Package.swift
└── Sources/
    └── Schema/
        ├── SchemaConfiguration.swift
        └── SchemaMetadata.graphql.swift

Step 2: Add the package to Xcode
In Xcode:
File → Add Package Dependencies...
Click Add Local...
Select the generated CountriesAPI folder (the one containing Package.swift).
Click Add Package.
Add the CountriesAPI product to your app target.

Step 3: Import the package
In your Swift file:
```
import CountriesAPI
```
Now this should compile:
```
let query = CountriesQuery()
```

Now this should compile:

```
let query = CountriesQuery()
```
