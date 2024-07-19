//
//  ReservationsUIView.swift
//  app724
//
//  Created by Dias Atudinov on 19.07.2024.
//

import SwiftUI

struct ReservationsUIView: View {
    @ObservedObject var viewModel: ResortViewModel
    @State private var showAddTrackSheet = false
    @State private var selectedResort: Resort?
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    HStack {
                        Text("Reservations")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                        Spacer()
                    }.padding(.horizontal)
                    ScrollView {
                        ForEach(viewModel.resorts, id: \.self){ resort in
                            ResortCellUIView(viewModel: viewModel, resort: resort).padding(.bottom, 13)
                                .onTapGesture {
                                    selectedResort = resort
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
                AddResortUIView(viewModel: viewModel, isAddResortOpen: $showAddTrackSheet)
            }
            .sheet(item: $selectedResort) { resort in
                // Sheet content
                ResortDetailsUIView(viewModel: viewModel, resort: resort)
                
                
            }
            
        }
    }
}

#Preview {
    ReservationsUIView(viewModel: ResortViewModel())
}
