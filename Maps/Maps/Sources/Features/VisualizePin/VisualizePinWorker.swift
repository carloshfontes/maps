//
//  VisualizePinWorker.swift
//  Maps
//
//  Created by Carlos Fontes on 04/07/22.
protocol VisualizePinWorkerLogic {
    func fetchLocations(completion: (Result<[Location], Error>) -> Void)
}

final class VisualizePinWorker {
    private let repository: LocationRepository
    
    init(repository: LocationRepository) {
        self.repository = repository
    }
}

extension VisualizePinWorker: VisualizePinWorkerLogic {
    func fetchLocations(completion: (Result<[Location], Error>) -> Void) {
        repository.fetchAll(completion: completion)
    }
}
