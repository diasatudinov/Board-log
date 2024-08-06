//
//  SettingsRiceTallUIView.swift
//  app724
//
//  Created by Dias Atudinov on 20.07.2024.
//

import SwiftUI

struct SettingsRiceTallUIView: View {
    @ObservedObject var viewModel = SettingsViewModel()
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack(spacing: 0) {
                
                VStack {
                    Spacer()
                    HStack {
                        Text("Settings")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        Spacer()
                    }.padding(16)
                }.frame(height: viewModel.standardNavBarHeight).padding(.bottom, 28)
                
                
                ScrollView {
                        VStack(spacing: 14) {
                            
                            ZStack {
                                Rectangle()
                                    .cornerRadius(18)
                                    .foregroundColor(.signupTextField)
                                HStack {
                                    Button {
                                        viewModel.openUsagePolicy()
                                    } label: {
                                        HStack {
                                            ZStack {
                                                Rectangle()
                                                    .foregroundColor(.onboardingButton)
                                                    .cornerRadius(11)
                                                    .frame(width: 32, height: 32)
                                                Image(systemName: "doc.text.fill")
                                                    .foregroundColor(.background)
                                                    .font(.system(size: 16))
                                            }
                                            Text("Usage policy")
                                                .foregroundColor(.white)
                                                .font(.system(size: 16, weight: .bold))
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.white)
                                                .font(.system(size: 17))
                                        }.padding()
                                    }
                                }
                            }
                            
                            ZStack {
                                Rectangle()
                                    .cornerRadius(18)
                                    .foregroundColor(.signupTextField)
                                HStack {
                                    Button {
                                        viewModel.rateApp()
                                    } label: {
                                        HStack {
                                            ZStack {
                                                Rectangle()
                                                    .foregroundColor(.onboardingButton)
                                                    .cornerRadius(11)
                                                    .frame(width: 32, height: 32)
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.background)
                                                    .font(.system(size: 16))
                                            }
                                            Text("Rate Us")
                                                .foregroundColor(.white)
                                                .font(.system(size: 16, weight: .bold))
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.white)
                                                .font(.system(size: 17))
                                        }.padding()
                                    }
                                }
                            }
                            
                            ZStack {
                                Rectangle()
                                    .cornerRadius(18)
                                    .foregroundColor(.signupTextField)
                                HStack {
                                    Button {
                                        viewModel.shareApp()
                                    } label: {
                                        HStack {
                                            ZStack {
                                                Rectangle()
                                                    .foregroundColor(.onboardingButton)
                                                    .cornerRadius(11)
                                                    .frame(width: 32, height: 32)
                                                Image(systemName: "square.and.arrow.up.fill")
                                                    .foregroundColor(.background)
                                                    .font(.system(size: 16))
                                            }
                                            Text("Share App")
                                                .foregroundColor(.white)
                                                .font(.system(size: 16, weight: .bold))
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.white)
                                                .font(.system(size: 17))
                                        }.padding()
                                    }
                                }
                            }
                        }.padding(.horizontal)
                }
                Spacer()
            }.padding(.bottom, 96)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    SettingsRiceTallUIView()
}

