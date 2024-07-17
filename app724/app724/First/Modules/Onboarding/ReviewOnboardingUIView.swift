//
//  reviewOnboardingUIView.swift
//  app724
//
//  Created by Dias Atudinov on 17.07.2024.
//

import SwiftUI

struct ReviewOnboardingUIView: View {
    @State private var pageNum: Int = 1
    @State private var showSheet = false
    @State private var signedUP = false
    
    var body: some View {
        if !signedUP {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    switch pageNum {
                    case 1: Image("appScreen1")
                            .resizable()
                            .frame(height: 549)
                            .ignoresSafeArea()
                    case 2: Image("appScreen2")
                            .resizable()
                            .frame(height: 549)
                            .ignoresSafeArea()
                    case 3: Image("appScreen3")
                            .resizable()
                            .frame(height: 549)
                            .ignoresSafeArea()
                    default:
                        Image("appScreen3")
                            .resizable()
                            .frame(height: 549)
                            .ignoresSafeArea()
                    }
                    
                    Button {
                        if pageNum < 3 {
                            pageNum += 1
                        } else {
                            showSheet = true
                            print("SHEET OUT")
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
                            .frame(width: 35, height: 6)
                            .cornerRadius(19)
                        
                        Rectangle()
                            .fill(pageNum == 2 ? Color.red : Color.gray.opacity(0.5))
                            .frame(width: 35, height: 6)
                            .cornerRadius(19)
                        
                        Rectangle()
                            .fill(pageNum > 2 ? Color.red : Color.gray.opacity(0.5))
                            .frame(width: 35, height: 6)
                            .cornerRadius(19)
                    }
                    .padding()
                    switch pageNum {
                    case 1:
                        Text("Upload photos of your \nraces")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .frame(height: 70)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                    case 2:
                        Text("Keep your booking \nhistory")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .frame(height: 70)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                    case 3:
                        Text("Save information about \nyour favorite routes")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .frame(height: 70)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                    default:
                        Text("Save information about \nyour favorite routes")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .frame(height: 70)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                        
                    }
                    
                }.padding(.bottom, UIScreen.main.bounds.height * 2/2.8)
            }.sheet(isPresented: $showSheet) {
                // Sheet content
                SignUpUIView(isSignedUp: $signedUP)
            }
        } else {
            TabUIView()
        }
    }
}

#Preview {
    ReviewOnboardingUIView()
}
