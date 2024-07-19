//
//  FavoriteTrailsUIView.swift
//  app724
//
//  Created by Dias Atudinov on 18.07.2024.
//

import SwiftUI

struct FavoriteTrailsUIView: View {
    @ObservedObject var viewModel: TrackViewModel
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            if viewModel.favoriteResorts.isEmpty {
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
                            Text("You don't have any favorite \ntracks yet!")
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
            } else {
                ScrollView {
                    ForEach(viewModel.favoriteResorts, id: \.self) { track in
                        TrackCellUIView(viewModel: viewModel, track: track)
                            .padding(.bottom, 13)
                    }
                }.padding(.horizontal)
            }
        }.navigationBarTitle("Favorite tracks", displayMode: .inline)
    }
}

#Preview {
    FavoriteTrailsUIView(viewModel: TrackViewModel())
}

//struct FavoriteResortsView: View {
//    @ObservedObject var viewModel: TrackViewModel
//
//    var body: some View {
//        List(viewModel.favoriteResorts) { track in
//            TrackCellUIView(viewModel: viewModel, track: track)
//        }
//        .navigationBarTitle("Favorite Resorts")
//    }
//}
