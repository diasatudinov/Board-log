//
//  TabUIView.swift
//  app724
//
//  Created by Dias Atudinov on 17.07.2024.
//

import SwiftUI
import AppMetricaCore

struct TabUIView: View {
    @State var selectedTab = 0
    @State var image: UIImage?
    private let tabs = ["Home", "Search", "Profile", "Training", "Settings"]
    @State private var profile: ProfileModel?
    @ObservedObject var profileVM = ProfileViewModel()
    @ObservedObject var trackVM = TrackViewModel()
    @ObservedObject var resortVM = ResortViewModel()
    @ObservedObject var trainingVM = TrainingViewModel()
    
    var body: some View {
        ZStack {
            
            switch selectedTab {
            case 0:
                ProfileUIView(profileVM: profileVM, trackVM: trackVM, resortVM: resortVM)
            case 1:
                TracksUIView(viewModel: trackVM)
            case 2:
                ReservationsUIView(viewModel: resortVM)
            case 3:
                TrainingUIView(viewModel: trainingVM)
            case 4:
                SettingsUIView()
            default:
                Text("default")
            }
            if !profileVM.isTabBarHidden {
                VStack {
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 61)
                            .fill(Color.tabViewIcon)
                            .frame(height: 70)
                            .padding(.horizontal, 36)
                        
                        HStack(spacing: 9) {
                            ForEach(0..<tabs.count) { index in
                                Button(action: {
                                    selectedTab = index
                                }) {
                                    if index == 0 {
                                        ZStack {
                                            Circle()
                                                .fill(selectedTab == index ? Color.onboardingButton : Color.tabViewCircle)
                                                .frame(width: 54, height: 54)
                                            if let image = image {
                                                Image(uiImage: image)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 54, height: 54)
                                                    .clipShape(Circle())
                                                    .foregroundColor(Color.tabViewIcon)
                                                    .font(.system(size: 16))
                                            } else {
                                                Image(systemName: "person.fill")
                                                    .foregroundColor(Color.tabViewIcon)
                                                    .font(.system(size: 16))
                                            }
                                        }
                                    } else {
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
                .onAppear {
                    loadProfile()
                    AppMetrica.reportEvent(name: "did_show_main_screen")
                }
            }
        }
    }
    
    private func icon(for index: Int) -> String {
        switch index {
        case 0: return "house.fill"
        case 1: return "flag.and.flag.filled.crossed"
        case 2: return "house.fill"
        case 3: return "bolt.fill"
        case 4: return "gearshape.fill"
        default: return ""
        }
    }
    
    func loadProfile() {
        if let data = UserDefaults.standard.data(forKey: "profile"),
           let decodedProfile = try? JSONDecoder().decode(ProfileModel.self, from: data) {
            profile = decodedProfile
            DispatchQueue.main.async {
                
                
                image = decodedProfile.image
            }
        }
    }
}

#Preview {
    TabUIView()
}
