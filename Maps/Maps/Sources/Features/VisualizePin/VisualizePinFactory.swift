//
//  VisualizePinFactory.swift
//  Maps
//
//  Created by Carlos Fontes on 04/07/22.
//
import UIKit.UIViewController

final class VisualizePinFactory {
    static func setup() -> UIViewController {
        let worker = VisualizePinWorker(repository: LocationCoreDataStorage())
        let presenter = VisualizePinPresenter()
        let interactor = VisualizePinInteractor(presenter: presenter, worker: worker)
        let view: VisualizePinViewConfigurable = VisualizePinView()
        let controller = VisualizePinViewController(customView: view, interactor: interactor)
        presenter.viewController = controller
        return controller
    }
}
