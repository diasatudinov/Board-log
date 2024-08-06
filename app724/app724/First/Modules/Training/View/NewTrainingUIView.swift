//
//  NewTrainingUIView.swift
//  app724
//
//  Created by Dias Atudinov on 05.08.2024.
//

import SwiftUI

struct NewTrainingUIView: View {
    @ObservedObject var viewModel: TrainingViewModel
    @State private var isShowingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var name = ""
    @State private var date = "Jan 1, 2024"
    @State private var maxSpeed = ""
    @State private var numDescents = ""
    @State private var numTricks = ""
    @State private var emoji = ""
    let allEmojis = ["🤩", "🙂", "🥲", "🥶"]
    @Binding var isAddTrainingOpen: Bool
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                
                Rectangle()
                    .frame(width: 36, height: 5)
                    .cornerRadius(100)
                    .opacity(0.25)
                    .padding()
                    .foregroundColor(.gray)
                
                ScrollView {
                    Text("New entry")
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .padding(.bottom, 25)
                    
                    VStack(spacing: 10) {
                        ZStack(alignment: .leading) {
                            
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
                        }
                        
                        ZStack(alignment: .leading) {
                            Text("")
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(20)
                                .background(Color.signupTextField)
                                .cornerRadius(18)
                            HStack {
                                Spacer()
                                TextField("", text: $date)
                                    .multilineTextAlignment(.trailing)
                                    .padding()
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .bold))
                                    .cornerRadius(18)
                                    .padding(.leading, 40)
                                
                            }
                            
                            Text("Date:")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 16)
                                .allowsHitTesting(false)
                            
                        }
                        
                        ZStack(alignment: .leading) {
                            
                            TextField("", text: $maxSpeed)
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(Color.signupTextField)
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .bold))
                                .cornerRadius(18)
                            if maxSpeed.isEmpty {
                                Text("Maximum speed")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 16)
                                    .allowsHitTesting(false)
                            }
                        }
                        
                        ZStack(alignment: .leading) {
                            
                            TextField("", text: $numDescents)
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(Color.signupTextField)
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .bold))
                                .cornerRadius(18)
                            if numDescents.isEmpty {
                                Text("Number of descents")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 16)
                                    .allowsHitTesting(false)
                            }
                        }
                        
                        ZStack(alignment: .leading) {
                            
                            TextField("", text: $numTricks)
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(Color.signupTextField)
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .bold))
                                .cornerRadius(18)
                            if numTricks.isEmpty {
                                Text("The number of tricks mastered")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 16)
                                    .allowsHitTesting(false)
                            }
                        }
                        
                    }.padding(.horizontal)
                        .padding(.bottom, 20)
                    
                    ZStack {
                        Rectangle()
                            .frame(height: 148)
                            .foregroundColor(.signupTextField)
                            .cornerRadius(12)
                        
                        VStack(spacing: 20) {
                            Text("Choose the appropriate \nemotion:")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                            
                            HStack {
                                ForEach(0...allEmojis.count - 1, id: \.self) { index in
                                    ZStack {
                                        Circle()
                                            .frame(width: 48)
                                            .foregroundColor(emoji == allEmojis[index] ?  .onboardingButton : Color.photoEditing.opacity(0.1))
                                        Text(allEmojis[index])
                                            .font(.system(size: 35))
                                            .onTapGesture {
                                                emoji = allEmojis[index]
                                                print(emoji)
                                            }
                                    }
                                }
                            }
                            
                            
                        }
                    }.padding(.horizontal)
                    
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Button {
                    
                    if !emoji.isEmpty && !name.isEmpty && !date.isEmpty && !maxSpeed.isEmpty && !numDescents.isEmpty && !numTricks.isEmpty{
                        
                            let training = Training(emoji: emoji, name: name, date: date, maxSpeed: maxSpeed, numDescents: numDescents, numTricks: numTricks)
                            viewModel.addTraining(training)
                        
                        isAddTrainingOpen = false
                    }
                    
                } label: {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .frame(height: 54)
                            .foregroundColor(Color.onboardingButton.opacity(!emoji.isEmpty && !name.isEmpty && !date.isEmpty && !maxSpeed.isEmpty && !numDescents.isEmpty && !numTricks.isEmpty ? 1 : 0.5))
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
        }
    }
}

#Preview {
    NewTrainingUIView(viewModel: TrainingViewModel(), isAddTrainingOpen: .constant(true))
}

//@State private var showEmojis = false
//@State private var emojis = [String]()
//
//let allEmojis = ["🤩", "🙂", "🥲", "🥶"]
//
//var body: some View {
//    VStack(spacing: 20) {
//        if showEmojis {
//            Text(emojis[0])
//                .font(.system(size: 85))
//                .transition(.opacity) // Optional transition for a fade effect
//        }
//        
//        Button(action: toggleEmojis) {
//            Text(showEmojis ? "Hide Emojis" : "Show Emojis")
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//        }
//    }
//    .padding()
//}
//
//private func toggleEmojis() {
//    withAnimation {
//        showEmojis.toggle()
//        if showEmojis {
//            // Select 5 random emojis
//            emojis = Array(allEmojis.shuffled().prefix(5))
//        }
//    }
//}

