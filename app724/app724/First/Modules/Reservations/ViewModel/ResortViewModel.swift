//
//  ResortViewModel.swift
//  app724
//
//  Created by Dias Atudinov on 19.07.2024.
//

import Foundation

class ResortViewModel: ObservableObject {
    @Published var resorts: [Resort] = [
        Resort(name: "Reservation 1", location: "Location 1", price: "200", rating: 5),
        Resort(name: "Reservation 2", location: "Location 2", price: "400", rating: 3)
        // Add more resorts here
    ]
    
    func addResort(_ resort: Resort) {
        resorts.append(resort)
    }
    
    func deleteResort(at index: Int) {
        guard index < resorts.count else { return }
        resorts.remove(at: index)
    }
    
    func toggleFavorite(for resort: Resort) {
        if let index = resorts.firstIndex(where: { $0.id == resort.id }) {
            resorts[index].isFavorite.toggle()
        }
    }
    
    func updateRating(for resort: Resort, rating: Int) {
        if let index = resorts.firstIndex(where: { $0.id == resort.id }) {
            resorts[index].rating = rating
        }
    }
    
    var favoriteResorts: [Resort] {
        resorts.filter { $0.isFavorite }
    }
}
