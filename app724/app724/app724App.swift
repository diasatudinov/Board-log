//
//  app724App.swift
//  app724
//
//  Created by Dias Atudinov on 17.07.2024.
//

import SwiftUI

@main
struct app724App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.clear
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            LoaderUIView()
        }
    }
}
