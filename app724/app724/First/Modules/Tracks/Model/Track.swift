//
//  Track.swift
//  app724
//
//  Created by Dias Atudinov on 19.07.2024.
//

import SwiftUI

struct Track: Identifiable, Hashable {
    let id = UUID()
    var imageData: Data?
    var name: String
    var length: String
    var location: String
    var rating: Int
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, imageData, name, length, location, rating, isFavorite
    }
    
    var image: UIImage? {
        get {
            guard let data = imageData else { return nil }
            return UIImage(data: data)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 1.0)
        }
    }
    
}
