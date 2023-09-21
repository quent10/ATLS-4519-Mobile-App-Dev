//
//  CountriesView.swift
//  ATLS 4519
//
//  Created by Quentin Wingard on 9/19/23.


import SwiftUI

struct Country: Codable, Identifiable {
    var id: Int { return UUID().hashValue }
    var name: CountryName
    var capital: [String]?
    var flag: String
    var population: Int
}

struct CountryName: Codable {
    var common: String
    var official: String
}

struct CountryDetailView: View {
    var country: Country

    var body: some View {
        VStack(alignment: .leading) {
            Text("Capital: \(country.capital?.joined(separator: ", ") ?? "N/A")")
            Text("Population: \(country.population)")
        }
        .padding()
        .navigationTitle(country.name.common)
    }
}

struct CountriesView: View {
    @State var countries =  [Country]()

    func getAllCountries() async -> () {
        do {
            let url = URL(string: "https://restcountries.com/v3.1/all")!
            let (data, _) = try await URLSession.shared.data(from: url)
            countries = try JSONDecoder().decode([Country].self, from: data)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    var body: some View {
        NavigationView {
            List(countries) { country in
                NavigationLink(destination: CountryDetailView(country: country)) {
                    HStack {
                        Text("\(country.flag)")
                        Text(country.name.common)
                    }
                }
            }
            .task {
                await getAllCountries()
            }
            .navigationTitle("Countries")
        }
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView()
    }
}
