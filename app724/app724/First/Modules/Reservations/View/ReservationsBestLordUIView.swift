//
//  ReservationsBestLordUIView.swift
//  app724
//
//  Created by Dias Atudinov on 19.07.2024.
//

import SwiftUI

struct ReservationsBestLordUIView: View {
    @ObservedObject var viewModel: ResortViewModel
    @State private var showAddTrackSheet = false
    @State private var selectedResort: ResortNatural?
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
                    if viewModel.resorts.isEmpty {
                        VStack {
                            ZStack {
                                Rectangle()
                                    .frame(height: 207)
                                    .cornerRadius(18)
                                    .foregroundColor(.signupTextField)
                                    .padding(.horizontal)
                                VStack(spacing: 0) {
                                    Image(systemName: "house")
                                        .font(.system(size: 28))
                                        .foregroundColor(.favoritesNumber.opacity(0.5))
                                        .padding(.top, 10)
                                        .padding(.bottom, 12)
                                    Text("Add a new reservation!")
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
                            ForEach(viewModel.resorts, id: \.self){ resort in
                                ResortShipCowCellUIView(viewModel: viewModel, resort: resort).padding(.bottom, 13)
                                    .onTapGesture {
                                        selectedResort = resort
                                    }
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
            }.sheet(isPresented: $showAddTrackSheet) {
                AddResortCoolestUIView(viewModel: viewModel, isAddResortOpen: $showAddTrackSheet)
            }
            .sheet(item: $selectedResort) { resort in
                ResortLowDetailsCowUIView(viewModel: viewModel, resort: resort)
                
                
            }
            
        }
    }
}

#Preview {
    ReservationsBestLordUIView(viewModel: ResortViewModel())
}
