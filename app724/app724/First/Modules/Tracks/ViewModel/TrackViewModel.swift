//
//  TrackViewModel.swift
//  app724
//
//  Created by Dias Atudinov on 19.07.2024.
//

import Foundation


class TrackViewModel: ObservableObject {
    @Published var tracks: [Track] = [
        Track(name: "Track 1", length: "1050m", location: "USA, Colorado", rating: 4),
        Track(name: "Track 2", length: "2350m", location: "UK, London", rating: 2)
        // Add more resorts here
    ]
    
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
}
