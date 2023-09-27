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
    @State private var searchText = ""
    @State private var countries = [Country]()

    func getAllCountries() async {
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
            VStack {
                SearchBar(text: $searchText)
                    .padding()

                List(countries.filter { searchText.isEmpty ? true : $0.name.common.lowercased().contains(searchText.lowercased()) }) { country in
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
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView()
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.leading, 10)
                .onTapGesture {
                    // Handle tap if needed
                }
            if !text.isEmpty {
                Button(action: {
                    withAnimation {
                        text = ""
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(.systemGray3))
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}
