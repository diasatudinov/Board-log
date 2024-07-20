//
//  ResortViewModel.swift
//  app724
//
//  Created by Dias Atudinov on 19.07.2024.
//

import SwiftUI

class ResortViewModel: ObservableObject {
    @Published var resorts: [Resort] = [] {
        didSet {
            saveResorts()
        }
    }
    
    private let resortsFileName = "resorts.json"
    
    init() {
        loadResorts()
    }
    
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
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func resortsFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(resortsFileName)
    }
    
    private func saveResorts() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self.resorts)
                try data.write(to: self.resortsFilePath())
            } catch {
                print("Failed to save players: \(error.localizedDescription)")
            }
        }
    }
    
    private func loadResorts() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: resortsFilePath())
            resorts = try decoder.decode([Resort].self, from: data)
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
    }
}
