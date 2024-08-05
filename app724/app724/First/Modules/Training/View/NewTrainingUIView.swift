//
//  NewTrainingUIView.swift
//  app724
//
//  Created by Dias Atudinov on 05.08.2024.
//

import SwiftUI

struct NewTrainingUIView: View {
    @State private var showEmojis = false
    @State private var emojis = [String]()
    
    let allEmojis = ["🤩", "🙂", "🥲", "🥶"]
    
    var body: some View {
        VStack(spacing: 20) {
            if showEmojis {
                Text(emojis[0])
                    .font(.system(size: 85))
                    .transition(.opacity) // Optional transition for a fade effect
            }
            
            Button(action: toggleEmojis) {
                Text(showEmojis ? "Hide Emojis" : "Show Emojis")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
    
    private func toggleEmojis() {
        withAnimation {
            showEmojis.toggle()
            if showEmojis {
                // Select 5 random emojis
                emojis = Array(allEmojis.shuffled().prefix(5))
            }
        }
    }
}

#Preview {
    NewTrainingUIView()
}
