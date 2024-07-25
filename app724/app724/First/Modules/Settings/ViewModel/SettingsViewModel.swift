//
//  SettingsViewModel.swift
//  app724
//
//  Created by Dias Atudinov on 20.07.2024.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    let standardNavBarHeight = UIScreen.main.bounds.height / 5.5
    
    func shareApp() {
        guard let url = URL(string: "https://apps.apple.com/app/board-log/id6575374222") else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func rateApp() {
        guard let url = URL(string: "https://apps.apple.com/app/board-log/id6575374222") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func openUsagePolicy() {
        guard let url = URL(string: "https://www.termsfeed.com/live/7fc0ddbb-49fe-4605-9f10-ffa4877cb79a") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
