//
//  Training.swift
//  app724
//
//  Created by Dias Atudinov on 05.08.2024.
//

import SwiftUI

struct Training: Identifiable, Hashable, Codable {
    let id = UUID()
    var emoji: String
    var name: String
    var date: String
    var maxSpeed: String
    var numDescents: String
    var numTricks: String
    
    enum CodingKeys: String, CodingKey {
        case id, emoji, name, date, maxSpeed, numDescents, numTricks
    }
    
}
