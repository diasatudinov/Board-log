//
//  Response.swift
//  app724
//
//  Created by Dias Atudinov on 22.07.2024.
//

import Foundation

struct ApiResponse: Codable {
    let isValid: String
    let active: String
    let hasParent: String
    let drawer: String
    let rotatable: [String]
    let isCurrent: [String]
    let isImproper: String
    let isApproved: String?  
    let nonremovable: Int
    let sortable: Bool
    let uiColorTheme: Bool
    
    enum CodingKeys: String, CodingKey {
        case isValid = "is_valid"
        case active
        case hasParent = "has_parent"
        case drawer
        case rotatable
        case isCurrent = "is_current"
        case isImproper = "is_improper"
        case isApproved = "is_approved"
        case nonremovable
        case sortable
        case uiColorTheme = "ui_color_theme"
    }
}
