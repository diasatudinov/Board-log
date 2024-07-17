//
//  SignUpUIView.swift
//  app724
//
//  Created by Dias Atudinov on 17.07.2024.
//

import SwiftUI

struct SignUpUIView: View {
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var name = ""
    @State private var experience = ""
    @Binding var isSignedUp: Bool
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
                    Text("Let's get acquainted!")
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .padding(.bottom, 25)
                    
                    ZStack {
                        Circle()
                            .frame(width: 166, height: 166)
                            .cornerRadius(12)
                            .foregroundColor(Color.signupTextField)
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 166, height: 166)
                                .clipShape(Circle())
                                .cornerRadius(6)
                        } else {
                            ZStack {
                                Circle()
                                    .frame(width: 166, height: 166)
                                    .cornerRadius(6)
                                    .foregroundColor(Color.signupTextField)
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 52, height: 52)
                                    .foregroundColor(Color.signUpPerson)
                            }
                        }
                    }.padding(.bottom, 24)
                        .onTapGesture {
                            //BrowseViewControllerStrangeThing()
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
                                Text("Name")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 16)
                                    .allowsHitTesting(false)
                            }
                        }
                        
                        
                        ZStack(alignment: .leading) {
                            
                            TextField("", text: $experience)
                                .padding()
                                .background(Color.signupTextField)
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .bold))
                                .cornerRadius(18)
                            if experience.isEmpty {
                                Text("Experience")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 16)
                                    .allowsHitTesting(false)
                            }
                        }
                        
                    }.padding(.horizontal)
                        .padding(.bottom, 24)
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Button {
                    isSignedUp = true
                } label: {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .frame(height: 54)
                            .foregroundColor(Color.onboardingButton.opacity(name.isEmpty || experience.isEmpty ? 0.5 : 1))
                            .font(.system(size: 17, weight: .bold))
                            .cornerRadius(16)
                            .padding(.horizontal)
                        Text("Save")
                            .font(.system(size: 17))
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
    SignUpUIView(isSignedUp: .constant(true))
}
