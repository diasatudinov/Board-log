//
//  TrainingViewModel.swift
//  app724
//
//  Created by Dias Atudinov on 05.08.2024.
//

import Foundation

class TrainingViewModel: ObservableObject {
    @Published var trainings: [Training] = [
        Training(emoji: "🥶", name: "Beaver Creek", date: "Jun 10, 2024", maxSpeed: "76", numDescents: "11", numTricks: "16"),
        Training(emoji: "🥶", name: "Beaver Creek", date: "Jun 10, 2024", maxSpeed: "76", numDescents: "11", numTricks: "16")] {
        didSet {
            saveTraining()
        }
    }
    
    private let trainingFileName = "training.json"
    
    init() {
        loadTraining()
    }
    
    func addTraining(_ training: Training) {
        trainings.append(training)
    }
    
    func deleteTraining(at index: Int) {
        guard index < trainings.count else { return }
        trainings.remove(at: index)
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func trainingsFilePath() -> URL {
        return getDocumentsDirectory().appendingPathComponent(trainingFileName)
    }
    
    private func saveTraining() {
        DispatchQueue.global().async {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(self.trainings)
                try data.write(to: self.trainingsFilePath())
            } catch {
                print("Failed to save players: \(error.localizedDescription)")
            }
        }
    }
    
    private func loadTraining() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: trainingsFilePath())
            trainings = try decoder.decode([Training].self, from: data)
        } catch {
            print("Failed to load players: \(error.localizedDescription)")
        }
    }
}
