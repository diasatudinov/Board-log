//
//  ProfileViewModel.swift
//  app724
//
//  Created by Dias Atudinov on 18.07.2024.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var images: [UIImage] = [] //{
//        didSet {
//            DispatchQueue.main.async {
//                self.saveImages()
//            }
//        }
    //}
    
    init() {
        loadImages()
    }
    private let imagesFileName = "players.json"
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func imagesFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(imagesFileName)
    }
    
    func saveImages() {
        DispatchQueue.global().async {
            let imageDataArray = self.images.compactMap { $0.pngData() }
            do {
                let data = try JSONEncoder().encode(imageDataArray)
                try data.write(to: self.imagesFilePath())
            } catch {
                print("Failed to save players: \(error.localizedDescription)")
            }
        }
    }
    
    private func loadImages() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: imagesFilePath())
            let imageDataArray = try JSONDecoder().decode([Data].self, from: data)
            images = imageDataArray.compactMap { UIImage(data: $0) }
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
    }
}
