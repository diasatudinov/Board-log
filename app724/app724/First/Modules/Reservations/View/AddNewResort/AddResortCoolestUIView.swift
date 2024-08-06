//
//  AddResortCoolestUIView.swift
//  app724
//
//  Created by Dias Atudinov on 19.07.2024.
//

import SwiftUI

struct AddResortCoolestUIView: View {
    @ObservedObject var viewModel: ResortViewModel
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var name = ""
    @State private var price = "0"
    @State private var location = ""
    @State private var rating: Int = 0
    @Binding var isAddResortOpen: Bool
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
                    Text("New reservation")
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .padding(.bottom, 25)
                    
                    ZStack {
                        if let image = selectedImage {
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
                                    Text("Add a hotel photo!")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }.padding(.bottom, 24).padding(.horizontal)
                        .onTapGesture {
                            isShowingImagePicker = true
                        }
                    
                    
                    VStack(spacing: 10) {
                        ZStack(alignment: .leading) {
                            
                            TextField("", text: $name)
                                .padding()
                                .background(Color.signupTextField)
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .bold))
                                .cornerRadius(18)
                            if name.isEmpty {
                                Text("Reservations name")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 16)
                                    .allowsHitTesting(false)
                            }
                        }
                        
                        ZStack(alignment: .leading) {
                            
                            TextField("", text: $location)
                                .padding()
                                .background(Color.signupTextField)
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .bold))
                                .cornerRadius(18)
                            if location.isEmpty {
                                HStack(spacing: 4) {
                                    Image(systemName: "mappin")
                                        .foregroundColor(.onboardingButton)
                                    Text("Location")
                                        .foregroundColor(.gray)
                                        .allowsHitTesting(false)
                                }.padding(.horizontal, 16)
                            }
                        }
                        
                        ZStack(alignment: .leading) {
                            Text("")
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(20)
                                .background(Color.signupTextField)
                                .cornerRadius(18)
                            HStack {
                                Spacer()
                                TextField("", text: $price)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                                    .padding()
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .bold))
                                    .cornerRadius(18)
                                    .padding(.trailing)
                                
                            }
                            HStack {
                                Spacer()
                                Text("$")
                                    .foregroundColor(.white)
                                    
                            }.padding()
                            
                                Text("Price per day:")
                                    .foregroundColor(price.isEmpty ? .gray : .white)
                                    .padding(.horizontal, 16)
                                    .allowsHitTesting(false)
                            
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
                            
                            StarUnrealRatingShipAddResort(viewModel: viewModel, rating: $rating)
                        }
                    }.padding(.horizontal)
                    
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Button {
                    
                    if !name.isEmpty && !price.isEmpty && !location.isEmpty && rating != 0 {
                        
                        if let image = selectedImage {
                            let resort = ResortNatural(imageData: image.jpegData(compressionQuality: 1.0), name: name, location: location, price: price, rating: rating)
                            viewModel.addResort(resort)
                        } else {
                            let resort = ResortNatural(name: name, location: location, price: price, rating: rating)
                            viewModel.addResort(resort)
                        }
                        isAddResortOpen = false
                    }
                    
                } label: {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .frame(height: 54)
                            .foregroundColor(Color.onboardingButton.opacity(!name.isEmpty && !price.isEmpty && !location.isEmpty && rating != 0 ? 1 : 0.5))
                            .font(.system(size: 17, weight: .bold))
                            .cornerRadius(16)
                            .padding(.horizontal)
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark")
                            Text("Save")
                                
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
    AddResortCoolestUIView(viewModel: ResortViewModel(), isAddResortOpen: .constant(true))
}

struct StarUnrealRatingShipAddResort: View {
    @ObservedObject var viewModel: ResortViewModel
    @Binding var rating: Int
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star.fill")
                    .font(.system(size: 30))
                    .foregroundColor(index <= rating ? .onboardingButton : .gray.opacity(0.3))
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
}
