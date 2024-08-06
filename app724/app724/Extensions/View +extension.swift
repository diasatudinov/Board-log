//
//  View +extension.swift
//  app724
//
//  Created by Dias Atudinov on 17.07.2024.
//

import SwiftUI

struct GlowBestBorderCool: ViewModifier {
    var color: Color
    var lineWidth: Int
    
    func body(content: Content) -> some View {
        applyShadow(content: AnyView(content), lineWidth: lineWidth)
    }
    
    func applyShadow(content: AnyView, lineWidth: Int) -> AnyView {
        if lineWidth == 0 {
            return content
        } else {
            return applyShadow(content: AnyView(content.shadow(color: color, radius: 0.5)), lineWidth: lineWidth - 1)
        }
    }
}

extension View {
    func glowBorder(color: Color, lineWidth: Int) -> some View {
        self.modifier(GlowBestBorderCool(color: color, lineWidth: lineWidth))
    }
}
