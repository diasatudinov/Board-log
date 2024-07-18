//
//  ProfileModel.swift
//  app724
//
//  Created by Dias Atudinov on 18.07.2024.
//

import SwiftUI

struct ProfileModel: Codable {
    var id = UUID()
    var imageData: Data?
    var name: String
    var experience: String
    
    enum CodingKeys: String, CodingKey {
        case id, imageData, name, experience
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
