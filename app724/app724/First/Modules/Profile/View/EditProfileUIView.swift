//
//  editProfileUIView.swift
//  app724
//
//  Created by Dias Atudinov on 18.07.2024.
//

import SwiftUI
import Combine

struct EditProfileUIView: View {
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var name = ""
    @State private var experience = ""
    @State private var profile: ProfileModel?
    @State private var editingProfile = true

    
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                
                ScrollView {
                    
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
                                if !editingProfile {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .frame(width: 52, height: 52)
                                        .foregroundColor(Color.signUpPerson)
                                }
                            }
                        }
                        
                        if editingProfile {
                            Circle()
                                .frame(width: 166, height: 166)
                                .cornerRadius(6)
                                .foregroundColor(Color.black.opacity(0.2))
                            Image(systemName: "camera.viewfinder")
                                .font(.system(size: 42))
                                .foregroundColor(.photoEditing.opacity(0.7))
                        }
                    }.padding(.bottom, 24).padding(.top, 28)
                        .onTapGesture {
                            //BrowseViewControllerStrangeThing()
                            if editingProfile {
                                isShowingImagePicker = true
                            }
                        }
                    
                    
                    VStack(spacing: 10) {
                        ZStack(alignment: .leading) {
                            
                            if editingProfile {
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
                            } else {
                                ZStack {
                                    Rectangle()
                                        .cornerRadius(18)
                                        .foregroundColor(.signupTextField)
                                    HStack {
                                        Text(name)
                                            .padding()
                                            .foregroundColor(.white)
                                            .font(.system(size: 17, weight: .bold))
                                        Spacer()
                                    }
                                }
                            }
                            if !editingProfile {
                            HStack {
                                Spacer()
                                
                                    Button {
                                        editingProfile = true
                                    } label: {
                                        Image(systemName: "square.and.pencil")
                                            .font(.system(size: 17, weight: .bold))
                                            .foregroundColor(.onboardingButton)
                                            .padding(.trailing)
                                    }
                                }
                            }
                        }
                        
                        
                        ZStack(alignment: .leading) {
                            if editingProfile {
                                TextField("", text: $experience)
                                    .padding([.trailing,.top,.bottom])
                                    .padding(.leading, 110)
                                    .background(Color.signupTextField)
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .bold))
                                    .cornerRadius(18)
                                
                                Text("Experience:")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 16)
                                    .allowsHitTesting(false)
                            } else {
                                ZStack {
                                    Rectangle()
                                        .cornerRadius(18)
                                        .foregroundColor(.signupTextField)
                                    HStack {
                                        Text("Experience:")
                                            .foregroundColor(.gray)
                                            .padding(.leading, 16)
                                            .allowsHitTesting(false)
                                        Text(experience)
                                            .padding(.vertical)
                                            .foregroundColor(.white)
                                            .font(.system(size: 17, weight: .bold))
                                        Spacer()
                                    }
                                }
                            }
                            if !editingProfile {
                                HStack {
                                    Spacer()
                                    Button {
                                        editingProfile = true
                                    } label: {
                                        Image(systemName: "square.and.pencil")
                                            .font(.system(size: 17, weight: .bold))
                                            .foregroundColor(.onboardingButton)
                                            .padding(.trailing)
                                    }
                                }
                            }
                        }
                        
                    }.padding(.horizontal)
                        .padding(.bottom, 24)
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                if editingProfile {
                    Button {
                        
                        if !name.isEmpty && !experience.isEmpty {
                            
                            if let image = selectedImage {
                                let profile = ProfileModel(imageData: image.jpegData(compressionQuality: 1.0), name: name, experience: experience)
                                saveProfile(profile)
                            } else {
                                let profile = ProfileModel(imageData: nil, name: name, experience: experience)
                                saveProfile(profile)
                            }
                            editingProfile = false
                        }
                    } label: {
                        ZStack(alignment: .center) {
                            Rectangle()
                                .frame(height: 54)
                                .foregroundColor(Color.onboardingButton.opacity(!name.isEmpty && !experience.isEmpty ? 1 : 0.5))
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
            }.padding(.bottom, 70)
                
        }
        .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: $selectedImage, isPresented: $isShowingImagePicker)
        }
        .onAppear {
            loadProfile()
        }
    }
    
    func loadImage() {
        if let selectedImage = selectedImage {
            print("Selected image size: \(selectedImage.size)")
        }
    }
    
    func saveProfile(_ profile: ProfileModel) {
        if let encoded = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(encoded, forKey: "profile")
        }
    }
    
    func loadProfile() {
        if let data = UserDefaults.standard.data(forKey: "profile"),
           let decodedProfile = try? JSONDecoder().decode(ProfileModel.self, from: data) {
            profile = decodedProfile
            selectedImage = decodedProfile.image
            name = decodedProfile.name
            experience = decodedProfile.experience
        }
    }
}

#Preview {
    EditProfileUIView()
}


class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        let keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { notification -> CGFloat in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    return keyboardFrame.height
                } else {
                    return 0
                }
            }
        
        let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ -> CGFloat in
                return 0
            }
        
        keyboardWillShow.merge(with: keyboardWillHide)
            .assign(to: \.currentHeight, on: self)
            .store(in: &cancellables)
    }
}

struct NavigationTitleColor: UIViewControllerRepresentable {
    var titleColor: UIColor

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .clear

        if let navigationController = viewController.navigationController {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: titleColor]
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
        }

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let navigationController = uiViewController.navigationController {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: titleColor]
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
        }
    }
}
