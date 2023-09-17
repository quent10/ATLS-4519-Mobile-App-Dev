//
//  ContentView.swift
//  Navigable App
//
//  Created by Quentin Wingard on 9/14/23.
//

import SwiftUI

struct ContentView: View {
   var platforms: [Platform] =  [.init(name: "Home", imageName: "house", color: .purple),
                                 .init(name: "Navigation", imageName: "map", color: .green),
                                 .init(name: "Alert", imageName: "bell", color: .red),
                                 .init(name: "Model Sheet", imageName: "pc", color: .orange)]

    var body: some View {
        NavigationStack {
            List {
                Section("Platforms") {
                    ForEach(platforms, id: \.name) { platform in
                        NavigationLink(value: platform) {
                            Label(platform.name, systemImage: platform.imageName)
                                .foregroundColor(platform.color)
                        }
                    }
                }
            }
            .navigationTitle("Welcome")
            .navigationDestination(for: Platform.self) {platform in
                ZStack {
                    platform.color.ignoresSafeArea()
                    Label(platform.name, systemImage: platform.imageName)
                        .font(.largeTitle).bold()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Platform: Hashable {
    let name: String
    let imageName: String
    let color: Color
}
