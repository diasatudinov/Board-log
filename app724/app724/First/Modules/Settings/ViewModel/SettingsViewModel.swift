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
        guard let url = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID") else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func rateApp() {
        guard let url = URL(string: "https://apps.apple.com/app/gear-up-playbook/id6511246643") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func openUsagePolicy() {
        guard let url = URL(string: "https://www.termsfeed.com/live/ea4add31-897e-48b9-bf34-e3ede7780771") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
