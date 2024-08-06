//
//  TrainingForwardCellUIView.swift
//  app724
//
//  Created by Dias Atudinov on 06.08.2024.
//

import SwiftUI

struct TrainingForwardCellUIView: View {
    @ObservedObject var viewModel: TrainingViewModel
    @State var training: TrainingBiggest
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.signupTextField)
                .frame(height: 249)
                .cornerRadius(18)
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.photoEditing.opacity(0.1))
                        .frame(height: 86)
                        .cornerRadius(12)
                    
                    VStack(spacing: 8) {
                        HStack {
                            Text(training.name)
                                .font(.system(size: 20, weight: .semibold))
                            Spacer()
                            ZStack {
                                Circle()
                                    .frame(width: 32)
                                    .foregroundColor(.signupTextField)
                                Text(training.emoji)
                                    .font(.system(size: 25))
                            }
                        }.padding(.horizontal, 24)
                        
                        HStack {
                            Text(training.date)
                                .font(.system(size: 13, weight: .semibold))
                            Spacer()
                        }.padding(.horizontal, 24)
                        
                    }.foregroundColor(.white)
                }.padding(12)
                
                VStack(spacing: 8) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(training.maxSpeed)
                                .font(.system(size: 17, weight: .semibold))

                            Text("Maximum speed")
                                .font(.system(size: 11))
                                .opacity(0.7)
                            
                        }.foregroundColor(.white)
                        
                        Spacer()
                        ZStack {
                            Circle()
                                .frame(width: 32)
                                .foregroundColor(Color.photoEditing.opacity(0.1))
                            Image("emojiBest1")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(training.numDescents)
                                .font(.system(size: 17, weight: .semibold))

                            Text("Number of descents")
                                .font(.system(size: 11))
                                .opacity(0.7)
                            
                        }.foregroundColor(.white)
                        
                        Spacer()
                        ZStack {
                            Circle()
                                .frame(width: 32)
                                .foregroundColor(Color.photoEditing.opacity(0.1))
                            Image("emojiBest2")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(training.numTricks)
                                .font(.system(size: 17, weight: .semibold))

                            Text("The number of tricks mastered")
                                .font(.system(size: 11))
                                .opacity(0.7)
                            
                        }.foregroundColor(.white)
                        
                        Spacer()
                        ZStack {
                            Circle()
                                .frame(width: 32)
                                .foregroundColor(Color.photoEditing.opacity(0.1))
                            Image("emojiBest3")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                }.padding(.horizontal,32)
                Spacer()
            }.frame(height: 249)
        }

    }
}


#Preview {
    TrainingForwardCellUIView(viewModel: TrainingViewModel(), training: TrainingBiggest(emoji: "🥶", name: "Beaver Creek", date: "Jun 10, 2024", maxSpeed: "76", numDescents: "11", numTricks: "16"))
}


//ZStack {
//    Rectangle()
//        .foregroundColor(.signupTextField)
//        .frame(height: 356)
//        .cornerRadius(18)
//    VStack {
//        HStack {
//            Text(training.name)
//                .font(.system(size: 20).bold())
//                .foregroundColor(.white)
//            Spacer()
//        }.padding(.horizontal).padding(.bottom, 12)
//        HStack(spacing: 6) {
//            Image(systemName: "mappin")
//                .foregroundColor(.onboardingButton)
//                .font(.system(size: 15))
//            Text(training.date)
//                .font(.system(size: 15))
//                .foregroundColor(.photoEditing)
//            Spacer()
//        }.padding(.horizontal).padding(.bottom, 15)
//
//        ZStack {
//            Text("")
//                .font(.system(size: 15))
//                .foregroundColor(.white)
//                .frame(maxWidth: .infinity)
//                .padding(9)
//                .background(Color.photoEditing.opacity(0.1))
//                .cornerRadius(9)
//                
//            HStack(spacing: 4) {
//                Text("Price per day:")
//                    .font(.system(size: 15, weight: .semibold))
//                Spacer()
//                Text("$")
//                    .font(.system(size: 20, weight: .semibold))
//                Text("\(training.maxSpeed)")
//                    .font(.system(size: 20, weight: .semibold))
//            }.foregroundColor(.white).padding(.horizontal)
//        }.padding(.horizontal).padding(.bottom, 15)
//        ZStack {
//            Rectangle()
//                .frame(height: 136)
//                .cornerRadius(12)
//                .foregroundColor(Color.signupTextField)
//            
//            
//                ZStack {
//                    Rectangle()
//                        .frame(height: 136)
//                        .cornerRadius(12)
//                        .foregroundColor(Color.background)
//                    Image(systemName: "photo.stack")
//                        .resizable()
//                        .frame(width: 52, height: 52)
//                        .foregroundColor(Color.icon)
//                }.padding(.horizontal)
//            
//        }.padding(.bottom, 15)
//        
//        HStack {
//            Text("Rating:")
//                .font(.system(size: 15).bold())
//                .foregroundColor(.white)
//            Spacer()
//            //StarResortRating(viewModel: viewModel, resort: training)
//        }.padding(.horizontal)
//        
//    }
//}
