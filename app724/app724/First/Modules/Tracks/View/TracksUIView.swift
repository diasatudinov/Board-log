//
//  TracksUIView.swift
//  app724
//
//  Created by Dias Atudinov on 19.07.2024.
//

import SwiftUI

struct TracksUIView: View {
    @ObservedObject var viewModel: TrackViewModel
    @State private var showAddTrackSheet = false
    @State private var selectedTrack: Track?
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    HStack {
                        Text("Tracks")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                        Spacer()
                    }.padding(.horizontal)
                    ScrollView {
                        ForEach(viewModel.tracks, id: \.self){ track in
                            TrackCellUIView(viewModel: viewModel, track: track).padding(.bottom, 13)
                                .onTapGesture {
                                    selectedTrack = track
                                }
                        }
                    }.padding(.horizontal).padding(.bottom, 40)
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
            }.sheet(isPresented: $showAddTrackSheet) {
                // Sheet content
                AddNewTrackUIView(viewModel: viewModel, isAddTrackOpen: $showAddTrackSheet)
            }
            .sheet(item: $selectedTrack) { track in
                // Sheet content
                TrackDetailsUIView(viewModel: viewModel, track: track)
                
                
            }
            
        }
    }
}

#Preview {
    TracksUIView(viewModel: TrackViewModel())
}
