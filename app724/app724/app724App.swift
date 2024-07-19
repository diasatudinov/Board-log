//
//  app724App.swift
//  app724
//
//  Created by Dias Atudinov on 17.07.2024.
//

import SwiftUI

@main
struct app724App: App {
    
    init() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.clear // Set background color if needed
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    
    var body: some Scene {
        WindowGroup {
            LoaderUIView()
            //TabUIView()
            //SignUpUIView()
        }
    }
}
