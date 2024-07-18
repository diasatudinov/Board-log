//
//  UserOnboardingUIView.swift
//  app724
//
//  Created by Dias Atudinov on 17.07.2024.
//

import SwiftUI
import StoreKit
import OneSignalFramework

struct UserOnboardingUIView: View {
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    @State private var isLoadingView: Bool = true
    @State private var isNotificationView: Bool = true
    @State private var pageNum: Int = 1
    
    var body: some View {
        if pageNum < 3 {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                ZStack {
                    VStack {
                        Spacer()
                        switch pageNum {
                        case 1: Image("firstScreen")
                                .resizable()
                                .frame(height: 549)
                                .ignoresSafeArea()
                        case 2: Image("ratings")
                                .resizable()
                                .frame(height: 549)
                                .ignoresSafeArea()
                        default:
                            Image("notifications")
                                .resizable()
                                .frame(height: 549)
                                .ignoresSafeArea()
                        }
                        
                        Button {
                            if pageNum < 3 {
                                pageNum += 1
                            } else {
                                
                            }
                            
                            
                        } label: {
                            Text("Next")
                                .foregroundColor(Color.onboardingButtonText)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                        }.background(Color.onboardingButton)
                            .cornerRadius(18)
                            .padding(.horizontal, 24)
                            .padding(.bottom)
                        
                    }
                    VStack {
                        HStack(spacing: 8) {
                            Rectangle()
                                .fill(pageNum == 1 ? Color.red : Color.gray.opacity(0.5))
                                .frame(width: 36, height: 6)
                                .cornerRadius(21)
                            
                            Rectangle()
                                .fill(pageNum == 2 ? Color.red : Color.gray.opacity(0.5))
                                .frame(width: 36, height: 6)
                                .cornerRadius(21)
                            
                        }
                        .padding()
                        switch pageNum {
                        case 1:
                            Text("Become popular \nand rich!")
                                .font(.title)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .frame(height: 70)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                            
                        case 2:
                            Text("Rate our app in the \nAppStore")
                                .font(.title)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .frame(height: 70)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .onAppear{
                                    rateApp()
                                }
                        default:
                            Text("Don’t miss anything")
                                .font(.title)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                            Text("Don’t miss the most userful information")
                                .foregroundColor(.white).opacity(0.7)
                            
                        }
                        
                    }.padding(.bottom, UIScreen.main.bounds.height * 2/2.9)
                    
                }
                
            }
        } else {
            if isNotificationView {
                ZStack {
                    Color.background
                        .ignoresSafeArea()
                    
                    ZStack {
                        VStack {
                            Spacer()
                            
                            Image("notifications")
                                .resizable()
                                .frame(height: 549)
                                .ignoresSafeArea()
                            
                            Button {
                                OneSignal.Notifications.requestPermission({ accepted in
                                    print("User accepted notifications: \(accepted)")
                                }, fallbackToSettings: true)
                            } label: {
                                
                                ZStack(alignment: .center) {
                                    Rectangle()
                                        .frame(height: 54)
                                        .foregroundColor(Color.onboardingButton)
                                        .font(.system(size: 17, weight: .bold))
                                        .cornerRadius(16)
                                        .padding(.horizontal)
                                    HStack(spacing: 4) {
                                        Image(systemName: "bell.badge")
                                        Text("Enable notification")
                                            
                                    }.font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.onboardingButtonText)
                                }
//                                }
                            }.background(Color.onboardingButton)
                                .cornerRadius(18)
                                .padding(.horizontal, 24)
                                .padding(.bottom)
                            
                        }
                        VStack {
                            HStack {
                                Spacer()
                                Button {
                                    isNotificationView = false
                                } label: {
                                    ZStack {
                                        Circle()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.gray.opacity(0.2))
                                        Image(systemName: "xmark")
                                            .font(.system(size: 16, weight: .heavy))
                                            .foregroundColor(.gray.opacity(0.76))
                                            
                                    }
                                }
                            }.padding(.horizontal, 32)
                            Spacer()
                            Text("Don't miss anything \nimportant!")
                                .font(.title)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .frame(height: 70)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.bottom, 10)
                        }.padding(.bottom, UIScreen.main.bounds.height * 2/2.6)
                    }
                }
                
            } else {
                Text("WEB View")
                //WebUIView()
            }
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 100 {
                progress += 1
            } else {
                timer.invalidate()
                isLoadingView.toggle()
            }
        }
    }
    
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            
        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

#Preview {
    UserOnboardingUIView()
}
