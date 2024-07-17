//
//  LoaderUIView.swift
//  app724
//
//  Created by Dias Atudinov on 17.07.2024.
//

import SwiftUI

struct LoaderUIView: View {
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    @State private var isLoadingView: Bool = true
    @State private var isWeb: Bool = true
    
    var body: some View {
        if isLoadingView {
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 230)
                        .padding(.top, UIScreen.main.bounds.height / 4.8)
                    Spacer()
                    Text("LOADING...")
                        .font(.system(size: 26))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(5)
                        .glowBorder(color: .black, lineWidth: 15)
                        .shadow(color: .black, radius: 3, x: 2, y: 2)
                        .padding()
                    ZStack {
                        
                        ProgressView(value: progress, total: 100)
                            .progressViewStyle(LinearProgressViewStyle())
                            .accentColor(.white)
                            .cornerRadius(15)
                            .scaleEffect(y: 2.5, anchor: .center)
                            .padding(.horizontal, 120)
                            .padding(.bottom, 60)
                            .glowBorder(color: .black, lineWidth: 3)
                    }
                    
                    
                }
                .onAppear {
                    startTimer()
                }
                .onDisappear {
                    timer?.invalidate()
                }
                
            }
            
        } else {
            if !isWeb {
                UserOnboardingUIView()
            } else {
                ReviewOnboardingUIView()
            }
        }
    }
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 100 {
                progress += 1
            } else {
                timer.invalidate()
                isLoadingView.toggle()
            }
        }
    }
}

#Preview {
    LoaderUIView()
}
