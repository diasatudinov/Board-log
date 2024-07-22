//
//  ProfileUIView.swift
//  app724
//
//  Created by Dias Atudinov on 18.07.2024.
//

import SwiftUI
import PhotosUI

struct ProfileUIView: View {
    @State var profile: ProfileModel?
    @State private var images2: [UIImage] = []
    @State private var showingImagePicker = false
    @ObservedObject var profileVM: ProfileViewModel
    @ObservedObject var trackVM: TrackViewModel
    @ObservedObject var resortVM: ResortViewModel

    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        
                        ZStack {
                            
                            Rectangle()
                                .frame(height: 358)
                                .cornerRadius(18)
                                .foregroundColor(.signupTextField)
                                .padding(.horizontal)
                            
                            VStack {
                                
                                HStack {
                                    Spacer()
                                    NavigationLink {
                                        EditProfileUIView(profileVM: profileVM)
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 40, height: 40)
                                                .foregroundColor(.background)
                                                .cornerRadius(11)
                                            
                                            Image(systemName: "square.and.pencil")
                                                .font(.system(size: 17, weight: .bold))
                                                .foregroundColor(.onboardingButton)
                                        }
                                    }
                                }.padding().padding(.trailing)
                                
                                ZStack {
                                    Circle()
                                        .frame(width: 166, height: 166)
                                        .cornerRadius(12)
                                        .foregroundColor(Color.signupTextField)
                                    if let image = profile?.image {
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
                                                .foregroundColor(Color.background)
                                            Image(systemName: "person.fill")
                                                .resizable()
                                                .frame(width: 52, height: 52)
                                                .foregroundColor(Color.icon)
                                        }
                                    }
                                }.padding(.bottom, 17)
                                if let profile = profile {
                                    Text(profile.name)
                                        .font(.system(size: 28, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.bottom, 7)
                                    
                                    HStack {
                                        Text("Experience:")
                                            .font(.system(size: 17))
                                            .foregroundColor(.white.opacity(0.5))
                                        Text(profile.experience)
                                            .font(.system(size: 17, weight: .semibold))
                                            .foregroundColor(.white)
                                    }
                                    
                                }
                                Spacer()
                            }
                            
                        }.padding(.bottom, 13)
                        
                        NavigationLink {
                            FavoriteTrailsUIView(viewModel: trackVM)
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(height: 65)
                                    .cornerRadius(18)
                                    .foregroundColor(.signupTextField)
                                    .padding(.horizontal)
                                
                                HStack {
                                    Image(systemName: "heart")
                                        .font(.system(size: 22, weight: .bold))
                                        .foregroundColor(.red)
                                    
                                    Text("Favorite trails")
                                        .font(.system(size: 17)
                                            .weight(.semibold))
                                        .foregroundColor(.white)
                                    Text("(\(trackVM.favoriteResorts.count))")
                                        .foregroundColor(.favoritesNumber.opacity(0.5))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.white)
                                }.padding(.horizontal,37)
                                
                            }.padding(.bottom, 13)
                        }
                        
                        
                        
                        NavigationLink {
                            FavoriteResortUIView(viewModel: resortVM)
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(height: 65)
                                    .cornerRadius(18)
                                    .foregroundColor(.signupTextField)
                                    .padding(.horizontal)
                                
                                HStack {
                                    Image(systemName: "house")
                                        .font(.system(size: 22, weight: .bold))
                                        .foregroundColor(.onboardingButton)
                                    
                                    Text("Favorite resort")
                                        .font(.system(size: 17)
                                            .weight(.semibold))
                                        .foregroundColor(.white)
                                    Text("(\(resortVM.favoriteResorts.count))")
                                        .foregroundColor(.favoritesNumber.opacity(0.5))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 17, weight: .semibold))
                                        .foregroundColor(.white)
                                }.padding(.horizontal,37)
                                
                            }.padding(.bottom, 13)
                        }
                        if profileVM.images.isEmpty {
                            ZStack {
                                Rectangle()
                                    .frame(height: 184)
                                    .cornerRadius(18)
                                    .foregroundColor(.signupTextField)
                                    .padding(.horizontal)
                                VStack {
                                    Image(systemName: "photo.stack")
                                        .font(.system(size: 28))
                                        .foregroundColor(.favoritesNumber.opacity(0.5))
                                        .padding(.bottom, 12)
                                    Text("Add riding photos!")
                                        .font(.system(size: 17).weight(.semibold))
                                        .foregroundColor(.white)
                                        .padding(.bottom, 28)
                                    Button {
                                        showingImagePicker = true
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
                        } else {
                            LazyVGrid(columns: Array(repeating: GridItem(.fixed(108), spacing: 13), count: 3), spacing: 13) {
                                // Add Image Button
                                Button(action: {
                                    showingImagePicker = true
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 108, height: 108)
                                            .foregroundColor(Color.signupTextField)
                                            .cornerRadius(18)
                                        Image(systemName: "plus")
                                            .font(.system(size: 30))
                                            .foregroundColor(.tabViewCircle)
                                        
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                
                                // Display Images
                                ForEach(profileVM.images, id: \.self) { image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 108, height: 108)
                                        .cornerRadius(18)
                                    
                                }
                            }
                        }
                    }.sheet(isPresented: $showingImagePicker, onDismiss: profileVM.saveImages) {
                        ImagePicker2(images: $profileVM.images)
                    }
                }.padding(.bottom, 40)
                
            }.onAppear {
                
                profileVM.showTabVisibility()
                loadProfile()
            }
        }
    }
    
    func loadProfile() {
        if let data = UserDefaults.standard.data(forKey: "profile"),
           let decodedProfile = try? JSONDecoder().decode(ProfileModel.self, from: data) {
            DispatchQueue.main.async {
                
                profile = decodedProfile
            }
        }
    }
}

#Preview {
    ProfileUIView(profile: ProfileModel(name: "AAAA", experience: "AAAAA"), profileVM: ProfileViewModel(), trackVM: TrackViewModel(), resortVM: ResortViewModel())
}



struct ImagePicker2: UIViewControllerRepresentable {
    @Binding var images: [UIImage]
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 0 // 0 means no limit
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker2
        
        init(_ parent: ImagePicker2) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        if let image = image as? UIImage {
                            DispatchQueue.main.async {
                                self?.parent.images.append(image)
                            }
                        }
                    }
                }
            }
        }
        
        
    }
}
