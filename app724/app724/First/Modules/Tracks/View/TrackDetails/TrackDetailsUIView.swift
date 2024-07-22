//
//  TrackDetailsUIView.swift
//  app724
//
//  Created by Dias Atudinov on 19.07.2024.
//

import SwiftUI

struct TrackDetailsUIView: View {
    @ObservedObject var viewModel: TrackViewModel
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State var track: Track
    @State private var name = ""
    @State private var length = ""
    @State private var location = ""
    @State private var rating: Int = 0
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                
                Rectangle()
                    .frame(width: 36, height: 5)
                    .cornerRadius(100)
                    .opacity(0.25)
                    .padding()
                    .foregroundColor(.gray)
                
                ScrollView {
                    Text(track.name)
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .padding(.bottom, 25)
                    
                    ZStack {
                        if let image = track.image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 148)
                                .clipShape(Rectangle())
                                .cornerRadius(6)
                        } else {
                            ZStack {
                                Rectangle()
                                    .frame(height: 148)
                                    .foregroundColor(.clear)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                        .inset(by: 1)
                                        .stroke(Color.onboardingButton.opacity(0.3), lineWidth: 2)

                                        )
                                VStack(spacing: 12) {
                                    Image(systemName: "camera.viewfinder")
                                        .resizable()
                                        .frame(width: 52, height: 52)
                                        .foregroundColor(Color.onboardingButton)
                                    Text("Add a track photo!")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }.padding(.bottom, 24).padding(.horizontal)
                    
                    
                    VStack(spacing: 10) {
                        ZStack {
                            Rectangle()
                                .cornerRadius(18)
                                .foregroundColor(.signupTextField)
                            HStack {
                                Text(track.name)
                                    .padding()
                                    .foregroundColor(.white)
                                    .font(.system(size: 17))
                                Spacer()
                            }
                        }
                        
                        
                        ZStack {
                            Rectangle()
                                .cornerRadius(18)
                                .foregroundColor(.signupTextField)
                            HStack {
                                Text(track.length)
                                    .padding()
                                    .foregroundColor(.white)
                                    .font(.system(size: 17))
                                Spacer()
                            }
                        }
                        
                        ZStack {
                            Rectangle()
                                .cornerRadius(18)
                                .foregroundColor(.signupTextField)
                            HStack(spacing: 4) {
                                Image(systemName: "mappin")
                                    .foregroundColor(.onboardingButton)
                                Text(track.location)
                                    .foregroundColor(.white)
                                    .font(.system(size: 17))
                                Spacer()
                            }.padding()
                        }
                        
                    }.padding(.horizontal)
                        .padding(.bottom, 20)
                    
                    ZStack {
                        Rectangle()
                            .frame(height: 148)
                            .foregroundColor(.signupTextField)
                            .cornerRadius(12)
                        
                        VStack(spacing: 20) {
                            Text("Rate the difficulty \nof the route:")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                            
                            StarRatingDetailsTrack(viewModel: viewModel, rating: track.rating)
                        }
                    }.padding(.horizontal)
                    
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Button {
                    if let index = viewModel.tracks.firstIndex(where: { $0.id == track.id  }) {
                        viewModel.deleteTrack(at: index)
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .frame(height: 54)
                            .foregroundColor(Color.red)
                            .font(.system(size: 17, weight: .bold))
                            .cornerRadius(16)
                            .padding(.horizontal)
                        HStack(spacing: 4) {
                            Image(systemName: "trash.fill")
                            Text("Delete")
                                
                        }.font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.onboardingButtonText)
                    }
                }.padding(.bottom, 10)
            }
        }
        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
        }
    }
    
    func loadImage() {
        if let selectedImage = selectedImage {
            print("Selected image size: \(selectedImage.size)")
        }
    }
}

#Preview {
    TrackDetailsUIView(viewModel: TrackViewModel(), track: Track(name: "Track 1", length: "1050m", location: "USA, Colorado", rating: 4))
}

struct StarRatingDetailsTrack: View {
    @ObservedObject var viewModel: TrackViewModel
    @State var rating: Int
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star.fill")
                    .font(.system(size: 30))
                    .foregroundColor(index <= rating ? .onboardingButton : .gray.opacity(0.3))
            }
        }
    }
}
