//
//  ContentView.swift
//  app724
//
//  Created by Dias Atudinov on 17.07.2024.
//

import SwiftUI
import PhotosUI
struct ContentView: View {
    @State private var images: [UIImage] = []
    @State private var showingImagePicker = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(108), spacing: 10), count: 3), spacing: 10) {
                    // Add Image Button
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 108, height: 108)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker2(images: $images)
                    }
                    
                    // Display Images
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 108, height: 108)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationTitle("Gallery")
        }
    }
}

#Preview {
    ContentView()
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
