//
//  reviewOnboardingUIView.swift
//  app724
//
//  Created by Dias Atudinov on 17.07.2024.
//

import SwiftUI

struct ReviewOnboardingUIView: View {
    @State private var pageNum: Int = 1

    var body: some View {
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
                        Image("appScreen1")
                            .resizable()
                            .frame(height: UIScreen.main.bounds.height * 0.7)
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
                            .frame(width: 35, height: 6)
                            .cornerRadius(19)
        
                        Rectangle()
                            .fill(pageNum == 2 ? Color.red : Color.gray.opacity(0.5))
                            .frame(width: 35, height: 6)
                            .cornerRadius(19)
        
                        Rectangle()
                            .fill(pageNum == 3 ? Color.red : Color.gray.opacity(0.5))
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
                        Text("Manage your team!")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .padding(.bottom, 10)
                        Text("Be your own trainer!")
                            .foregroundColor(.white).opacity(0.7)
        
                    }
        
                }.padding(.bottom, UIScreen.main.bounds.height * 2/2.8)
            }

    }
}

#Preview {
    ReviewOnboardingUIView()
}
