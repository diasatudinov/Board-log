//
//  TrainingViewModel.swift
//  app724
//
//  Created by Dias Atudinov on 05.08.2024.
//

import Foundation

class TrainingViewModel: ObservableObject {
    @Published var tracks: [Track] = [] {
        didSet {
            saveTracks()
        }
    }
    
    private let tracksFileName = "tracks.json"
    
    init() {
        loadTracks()
    }
    
    func addTracks(_ track: Track) {
        tracks.append(track)
    }
    
    func deleteTrack(at index: Int) {
        guard index < tracks.count else { return }
        tracks.remove(at: index)
    }
    
    func toggleFavorite(for track: Track) {
        if let index = tracks.firstIndex(where: { $0.id == track.id }) {
            tracks[index].isFavorite.toggle()
        }
    }
    
    func updateRating(for track: Track, rating: Int) {
        if let index = tracks.firstIndex(where: { $0.id == track.id }) {
            tracks[index].rating = rating
        }
    }
    
    var favoriteResorts: [Track] {
        tracks.filter { $0.isFavorite }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func tracksFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(tracksFileName)
    }
    
    private func saveTracks() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self.tracks)
                try data.write(to: self.tracksFilePath())
            } catch {
                print("Failed to save players: \(error.localizedDescription)")
            }
        }
    }
    
    private func loadTracks() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: tracksFilePath())
            tracks = try decoder.decode([Track].self, from: data)
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
    }
}
