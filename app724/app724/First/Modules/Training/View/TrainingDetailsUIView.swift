//
//  TrainingDetailsUIView.swift
//  app724
//
//  Created by Dias Atudinov on 06.08.2024.
//

import SwiftUI

struct TrainingDetailsUIView: View {
    @ObservedObject var viewModel: TrainingViewModel
    @State var training: Training

    let allEmojis = ["🤩", "🙂", "🥲", "🥶"]
    @Environment(\.presentationMode) var presentationMode
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
                        ZStack {
                            Rectangle()
                                .cornerRadius(18)
                                .foregroundColor(.signupTextField)
                            HStack {
                                Text(training.name)
                                    .padding()
                                    .foregroundColor(.white)
                                    .font(.system(size: 17))
                                Spacer()
                            }
                        }
                        
                        ZStack {
                            Rectangle()
                                .cornerRadius(18)
                                .foregroundColor(.signupTextField)
                            HStack {
                                Spacer()
                                Text(training.date)
                                    .multilineTextAlignment(.trailing)
                                    .padding()
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .semibold))
                                    .padding(.leading, 40)
                                
                            }
                            
                            HStack {
                                Text("Date:")
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .allowsHitTesting(false)
                                Spacer()
                            }
                        }
                        
                        ZStack {
                            Rectangle()
                                .cornerRadius(18)
                                .foregroundColor(.signupTextField)
                            HStack {
                                Text(training.maxSpeed)
                                    .padding()
                                    .foregroundColor(.white)
                                    .font(.system(size: 17))
                                Spacer()
                            }
                        }
                        
                        ZStack {
                            Rectangle()
                                .cornerRadius(18)
                                .foregroundColor(.signupTextField)
                            HStack {
                                Text(training.numDescents)
                                    .padding()
                                    .foregroundColor(.white)
                                    .font(.system(size: 17))
                                Spacer()
                            }
                        }
                        
                        ZStack {
                            Rectangle()
                                .cornerRadius(18)
                                .foregroundColor(.signupTextField)
                            HStack {
                                Text(training.numTricks)
                                    .padding()
                                    .foregroundColor(.white)
                                    .font(.system(size: 17))
                                Spacer()
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
                                            .foregroundColor(training.emoji == allEmojis[index] ?  .onboardingButton : Color.photoEditing.opacity(0.1))
                                        Text(allEmojis[index])
                                            .font(.system(size: 35))
                                            
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
                    if let index = viewModel.trainings.firstIndex(where: { $0.id == training.id  }) {
                        viewModel.deleteTraining(at: index)
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    ZStack(alignment: .center) {
                        Rectangle()
                            .frame(height: 54)
                            .foregroundColor(Color.red)
                            .font(.system(size: 17, weight: .bold))
                            .cornerRadius(16)
                            .padding(.horizontal)
                        HStack(spacing: 4) {
                            Image(systemName: "trash.fill")
                            Text("Delete")
                                
                        }.font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.onboardingButtonText)
                    }
                }.padding(.bottom, 10)
            }
        }
    }
}

#Preview {
    TrainingDetailsUIView(viewModel: TrainingViewModel(), training: Training(emoji: "🥶", name: "AAA", date: "aaa", maxSpeed: "12", numDescents: "23", numTricks: "5"))
}
