//
//  TabUIView.swift
//  app724
//
//  Created by Dias Atudinov on 17.07.2024.
//

import SwiftUI

struct TabUIView: View {
//    @ObservedObject var teamVM = TeamViewModel()
//    @ObservedObject var inventoryVM = InventoryViewModel()
//    @ObservedObject var itemVM = ItemViewModel()
//    @ObservedObject var calendarVM = CalendarViewModel()
    
//    init() {
//        UITabBar.appearance().backgroundColor = UIColor.tabBar
//        
//        let tabBarAppearance = UITabBarAppearance()
//        
//        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.white
//        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        
//        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.onboardingText
//        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.onboardingText]
//        
//        UITabBar.appearance().standardAppearance = tabBarAppearance
//    }
    @State var selectedTab = 0
    private let tabs = ["Home", "Search", "Profile", "Settings"]
    
    var body: some View {
        ZStack {
            
            switch selectedTab {
            case 0:
                Text("Profile")
            case 1:
                Text("Tracks")
            case 2:
                Text("HOME")
            case 3:
                Text("SETTINGS")
            default:
                Text("FIVETH")
            }
            VStack {
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 61)
                        .fill(Color.tabViewIcon)
                        .frame(height: 70)
                        .padding(.horizontal, 68)
                    
                    HStack(spacing: 9) {
                        ForEach(0..<tabs.count) { index in
                            Button(action: {
                                selectedTab = index
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(selectedTab == index ? Color.onboardingButton : Color.tabViewCircle)
                                        .frame(width: 54, height: 54)
                                    
                                    Image(systemName: icon(for: index))
                                        .foregroundColor(Color.tabViewIcon)
                                        .font(.system(size: 16))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func icon(for index: Int) -> String {
        switch index {
        case 0: return "house.fill"
        case 1: return "flag.and.flag.filled.crossed"
        case 2: return "house.fill"
        case 3: return "gearshape.fill"
        default: return ""
        }
    }
}

#Preview {
    TabUIView()
}
