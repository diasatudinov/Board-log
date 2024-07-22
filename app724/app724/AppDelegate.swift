//
//  AppDelegate.swift
//  app724
//
//  Created by Dias Atudinov on 22.07.2024.
//

import UIKit
import OneSignalFramework
import ApphudSDK
import AppMetricaCore

class AppDelegate: NSObject, UIApplicationDelegate {
    static var apiResponse: ApiResponse?
    var errorMessage: String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Perform setup tasks here
        
//        Apphud.start(apiKey: "app_MqZYeTGkCQWTtAmAocW9JcBkhh7j3u")
//        OneSignal.initialize("b3363ec1-8d0a-4115-9e1c-31a753b03dcd", withLaunchOptions: launchOptions)
//        OneSignal.login(Apphud.userID())
//        
//        let configuration = AppMetricaConfiguration.init(apiKey: "api-key")
        //AppMetrica.activate(with: configuration)

        
        let apiService = ApiService()
        
        
        apiService.fetchData { result in
            switch result {
            case .success(let data):
                AppDelegate.apiResponse = data
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
        print("AppDelegate: didFinishLaunchingWithOptions")
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Handle app entering background
        print("AppDelegate: applicationDidEnterBackground")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Handle app entering foreground
        print("AppDelegate: applicationWillEnterForeground")
    }
    
    // Implement other UIApplicationDelegate methods as needed
}
