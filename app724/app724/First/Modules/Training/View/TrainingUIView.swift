//
//  TrainingUIView.swift
//  app724
//
//  Created by Dias Atudinov on 05.08.2024.
//

import SwiftUI

struct TrainingUIView: View {
    @ObservedObject var viewModel: TrainingViewModel
    @State private var showAddTrackSheet = false
    @State private var selectedTrack: Track?
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    HStack {
                        Text("Training")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                        Spacer()
                    }.padding(.horizontal)
                    
                    if viewModel.tracks.isEmpty {
                        VStack {
                            ZStack {
                                Rectangle()
                                    .frame(height: 207)
                                    .cornerRadius(18)
                                    .foregroundColor(.signupTextField)
                                    .padding(.horizontal)
                                VStack(spacing: 0) {
                                    Image(systemName: "bolt.fill")
                                        .font(.system(size: 28))
                                        .foregroundColor(.favoritesNumber.opacity(0.5))
                                        .padding(.top, 10)
                                        .padding(.bottom, 12)
                                    Text("Add a new workout!")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 17).weight(.semibold))
                                        .foregroundColor(.white)
                                        .padding(.bottom, 25)
                                    Button {
                                        showAddTrackSheet = true
                                    } label: {
                                        ZStack(alignment: .center) {
                                            Rectangle()
                                                .frame(height: 46)
                                                .foregroundColor(Color.onboardingButton)
                                                .font(.system(size: 17, weight: .bold))
                                                .cornerRadius(16)
                                                .padding(.horizontal, 30)
                                            HStack(spacing: 4) {
                                                Image(systemName: "plus")
                                                    .font(.system(size: 16, weight: .semibold))
                                                Text("Add")
                                                    .font(.system(size: 17, weight: .semibold))
                                                
                                            }.foregroundColor(.black)
                                        }
                                    }
                                }
                                
                            }
                            Spacer()
                        }
                    } else {
                        ScrollView {
                            ForEach(viewModel.tracks, id: \.self){ track in
//                                TrackCellUIView(viewModel: viewModel, track: track).padding(.bottom, 13)
//                                    .onTapGesture {
//                                        selectedTrack = track
//                                    }
                            }
                        }.padding(.horizontal).padding(.bottom, 40)
                    }
                }
                .navigationBarItems(trailing:
                                        Button {
                    showAddTrackSheet = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.onboardingButton)
                        .font(.title2)
                        
                }
                )
            }
            .sheet(isPresented: $showAddTrackSheet) {
                //AddNewTrackUIView(viewModel: viewModel, isAddTrackOpen: $showAddTrackSheet)
            }
            .sheet(item: $selectedTrack) { track in
                //TrackDetailsUIView(viewModel: viewModel, track: track)
                
                
            }
            
        }
    }
}

#Preview {
    TrainingUIView(viewModel: TrainingViewModel())
}
