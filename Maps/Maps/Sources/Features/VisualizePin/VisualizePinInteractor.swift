//
//  VisualizePinInteractor.swift
//  Maps
//
//  Created by Carlos Fontes on 04/07/22.
//
protocol VisualizePinBusinessLogic {
    func fetchLocations()
}

final class VisualizePinInteractor {
    let presenter: VisualizePinPresentationLogic
    let worker: VisualizePinWorkerLogic
    
    init(
        presenter: VisualizePinPresentationLogic,
        worker: VisualizePinWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }

}

extension VisualizePinInteractor: VisualizePinBusinessLogic {
    func fetchLocations() {
        worker.fetchLocations { [weak self] result in
            switch result {
            case .success(let locations):
                self?.presenter.presentLocations(locations)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
