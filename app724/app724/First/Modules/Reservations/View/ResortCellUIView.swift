//
//  ResortCellUIView.swift
//  app724
//
//  Created by Dias Atudinov on 19.07.2024.
//

import SwiftUI

struct ResortCellUIView: View {
    @ObservedObject var viewModel: ResortViewModel
    @State var resort: Resort
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.signupTextField)
                .frame(height: 356)
                .cornerRadius(18)
            VStack {
                HStack {
                    Text(resort.name)
                        .font(.system(size: 20).bold())
                        .foregroundColor(.white)
                    Spacer()
                    Button {
                        viewModel.toggleFavorite(for: resort)
                    } label: {
                        Image(systemName: resort.isFavorite ? "heart.fill" : "heart.slash")
                            .foregroundColor(resort.isFavorite ? .red : .gray)
                            .font(.system(size: 20))
                    }
                }.padding(.horizontal).padding(.bottom, 12)
                HStack(spacing: 6) {
                    Image(systemName: "mappin")
                        .foregroundColor(.onboardingButton)
                        .font(.system(size: 15))
                    Text(resort.location)
                        .font(.system(size: 15))
                        .foregroundColor(.photoEditing)
                    Spacer()
                }.padding(.horizontal).padding(.bottom, 15)

                ZStack {
                    Text("")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(9)
                        .background(Color.photoEditing.opacity(0.1))
                        .cornerRadius(9)
                        
                    HStack(spacing: 4) {
                        Text("Price per day:")
                            .font(.system(size: 15, weight: .semibold))
                        Spacer()
                        Text("$")
                            .font(.system(size: 20, weight: .semibold))
                        Text("\(resort.price)")
                            .font(.system(size: 20, weight: .semibold))
                    }.foregroundColor(.white).padding(.horizontal)
                }.padding(.horizontal).padding(.bottom, 15)
                ZStack {
                    Rectangle()
                        .frame(height: 136)
                        .cornerRadius(12)
                        .foregroundColor(Color.signupTextField)
                    if let image = resort.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 136)
                            .clipShape(Rectangle())
                            .cornerRadius(12)
                            .padding(.horizontal)
                    } else {
                        ZStack {
                            Rectangle()
                                .frame(height: 136)
                                .cornerRadius(12)
                                .foregroundColor(Color.background)
                            Image(systemName: "photo.stack")
                                .resizable()
                                .frame(width: 52, height: 52)
                                .foregroundColor(Color.icon)
                        }.padding(.horizontal)
                    }
                }.padding(.bottom, 15)
                
                HStack {
                    Text("Rating:")
                        .font(.system(size: 15).bold())
                        .foregroundColor(.white)
                    Spacer()
                    StarResortRating(viewModel: viewModel, resort: resort)
                }.padding(.horizontal)
                
            }
        }

    }
}

#Preview {
    ResortCellUIView(viewModel: ResortViewModel(), resort: Resort(name: "Reservation 1", location: "Location 1", price: "100", rating: 5))
}

struct StarResortRating: View {
    @ObservedObject var viewModel: ResortViewModel
    var resort: Resort
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= resort.rating ? "star.fill" : "star.fill")
                    .font(.system(size: 20))
                    .foregroundColor(index <= resort.rating ? .onboardingButton : .gray.opacity(0.3))
            }
        }
    }
}
