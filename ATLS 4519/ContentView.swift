//
//  ContentView.swift
//  Navigable App
//
//  Created by Quentin Wingard on 9/14/23.
//

import SwiftUI

struct ContentView: View {
    @State var optionalString: String?
    var body: some View {
        TabView {
            WelcomePageView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            NavPageView()
                .tabItem {
                    Label("Navigation", systemImage: "map")
                }
        }
    }
}


struct WelcomePageView: View {
    @State private var showingAlert = false
    @State private var counter = 0
    @State private var showingSheet = false
    var body: some View {
        Text("Bonjour")
        Button("Alert") {
            showingAlert = true
        }
        .alert("Strike?", isPresented: $showingAlert) {
            Button("Add to counter", role: .none) {
                counter += 1
            }
            Button("Subtract", role: .cancel) {
                counter -= 1
            }
        }
        Button("Sheet") {
            showingSheet = true
        }
        .sheet(isPresented: $showingSheet) {
            SheetView()
        }
    }
}

struct NavPageView: View {
    var body: some View {
        Text("Navigation")
            .foregroundColor(.red)
    }
}

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button("Press to dismiss"){
            dismiss()
        }
    }
}
