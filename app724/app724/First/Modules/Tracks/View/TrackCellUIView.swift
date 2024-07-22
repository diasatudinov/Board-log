//
//  TrackCellUIView.swift
//  app724
//
//  Created by Dias Atudinov on 19.07.2024.
//

import SwiftUI


struct TrackCellUIView: View {
    @ObservedObject var viewModel: TrackViewModel
    @State var track: Track
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.signupTextField)
                .frame(height: 320)
                .cornerRadius(18)
            VStack {
                HStack {
                    Text(track.name)
                        .font(.system(size: 20).bold())
                        .foregroundColor(.white)
                    Spacer()
                    Button {
                        viewModel.toggleFavorite(for: track)
                    } label: {
                        Image(systemName: track.isFavorite ? "heart.fill" : "heart.slash")
                            .foregroundColor(track.isFavorite ? .red : .gray)
                            .font(.system(size: 20))
                    }
                }.padding(.horizontal).padding(.bottom, 12)
                HStack(spacing: 6) {
                    Image(systemName: "flag.filled.and.flag.crossed")
                        .foregroundColor(.onboardingButton)
                        .font(.system(size: 15))
                    Text(track.location)
                        .font(.system(size: 15))
                        .foregroundColor(.photoEditing)
                    Text("·")
                        .font(.system(size: 15))
                        .foregroundColor(.photoEditing)
                    Text(track.length)
                        .font(.system(size: 15))
                        .foregroundColor(.photoEditing)
                    Spacer()
                }.padding(.horizontal).padding(.bottom, 20)
                
                ZStack {
                    Rectangle()
                        .frame(height: 136)
                        .cornerRadius(12)
                        .foregroundColor(Color.signupTextField)
                    if let image = track.image {
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
                }.padding(.bottom, 20)
                
                HStack {
                    Text("Complexity:")
                        .font(.system(size: 15).bold())
                        .foregroundColor(.white)
                    Spacer()
                    StarRating(viewModel: viewModel, resort: track)
                }.padding(.horizontal)
                
            }
        }

    }
}


struct StarRating: View {
    @ObservedObject var viewModel: TrackViewModel
    var resort: Track
    
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
#Preview {
    TrackCellUIView(viewModel: TrackViewModel(), track: Track(name: "Beaver Creek", length: "1050m", location: "USA, Colorado", rating: 2))
}
