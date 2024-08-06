//
//  ResortLowDetailsCowUIView.swift
//  app724
//
//  Created by Dias Atudinov on 19.07.2024.
//

import SwiftUI

struct ResortLowDetailsCowUIView: View {
    @ObservedObject var viewModel: ResortViewModel
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State var resort: ResortNatural
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
                    Text(resort.name)
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .padding(.bottom, 25)
                    
                    ZStack {
                        if let image = resort.image {
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
                                Text(resort.name)
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
                                Text(resort.location)
                                    .foregroundColor(.white)
                                    .font(.system(size: 17))
                                Spacer()
                            }.padding()
                        }
                        
                        ZStack {
                            Rectangle()
                                .cornerRadius(18)
                                .foregroundColor(.signupTextField)
                            HStack {
                                Text("Price per day:")
                                    .font(.system(size: 17))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$ \(resort.price)")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17,weight: .semibold))
                                
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
                            Text("Rate the quality of the \nhousing provided:")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                            
                            StarRatingDetailsResort(viewModel: viewModel, rating: resort.rating)
                        }
                    }.padding(.horizontal)
                    
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Button {
                    if let index = viewModel.resorts.firstIndex(where: { $0.id == resort.id  }) {
                        viewModel.deleteResort(at: index)
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
    ResortLowDetailsCowUIView(viewModel: ResortViewModel(), resort: ResortNatural(name: "Reservation 1", location: "Location 1", price: "200", rating: 5))
}

struct StarRatingDetailsResort: View {
    @ObservedObject var viewModel: ResortViewModel
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
