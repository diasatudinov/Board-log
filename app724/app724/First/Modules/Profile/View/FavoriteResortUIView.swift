//
//  FavoriteResortUIView.swift
//  app724
//
//  Created by Dias Atudinov on 18.07.2024.
//

import SwiftUI

struct FavoriteResortUIView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            if true {
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(height: 207)
                            .cornerRadius(18)
                            .foregroundColor(.signupTextField)
                            .padding(.horizontal)
                        VStack(spacing: 0) {
                            Image(systemName: "heart")
                                .font(.system(size: 28))
                                .foregroundColor(.favoritesNumber.opacity(0.5))
                                .padding(.top, 10)
                                .padding(.bottom, 12)
                            Text("You don't have any favorite \nreservations yet!")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 17).weight(.semibold))
                                .foregroundColor(.white)
                                .padding(.bottom, 25)
                            Button {
                                
                            } label: {
                                ZStack(alignment: .center) {
                                    Rectangle()
                                        .frame(height: 46)
                                        .foregroundColor(Color.onboardingButton)
                                        .font(.system(size: 17, weight: .bold))
                                        .cornerRadius(16)
                                        .padding(.horizontal, 30)
                                    HStack(spacing: 4) {
                                        Image(systemName: "plus")
                                            .font(.system(size: 16, weight: .semibold))
                                        Text("Add")
                                            .font(.system(size: 17, weight: .semibold))
                                        
                                    }.foregroundColor(.black)
                                }
                            }
                        }
                        
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    FavoriteResortUIView()
}
