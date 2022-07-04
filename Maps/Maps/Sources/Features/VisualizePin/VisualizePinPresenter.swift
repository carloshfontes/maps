//
//  VisualizePinPresenter.swift
//  Maps
//
//  Created by Carlos Fontes on 04/07/22.
//
protocol VisualizePinPresentationLogic {
    func presentLocations(_ locations: [Location])
}

final class VisualizePinPresenter {
    weak var viewController: VisualizePinDisplayLogic?
}

extension VisualizePinPresenter: VisualizePinPresentationLogic {
    func presentLocations(_ locations: [Location]) {
        viewController?.displayLocations(locations)
    }
}
