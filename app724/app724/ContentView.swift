//
//  ContentView.swift
//  app724
//
//  Created by Dias Atudinov on 17.07.2024.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State private var lastVisitedURL: URL? = UserDefaults.standard.url(forKey: "lastVisitedURL") ?? URL(string: "https://google.com")

    var body: some View {
        WebView(lastVisitedURL: $lastVisitedURL)
            .onAppear {
                loadLastVisitedURL()
            }
    }

    private func loadLastVisitedURL() {
        if let savedURL = UserDefaults.standard.url(forKey: "lastVisitedURL") {
            lastVisitedURL = savedURL
        }
    }
}

#Preview {
    ContentView()
}
