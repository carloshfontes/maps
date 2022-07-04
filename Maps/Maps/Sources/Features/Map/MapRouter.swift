//
//  MapRouter.swift
//  Maps
//
//  Created by Carlos Fontes on 03/07/22.
//
import UIKit.UIViewController

protocol MapRoutingLogic {
    var viewController: UIViewController? { get set }
    func routeToAddPin()
    func routeToVisualizePin()
}

final class MapRouter {
    weak var viewController: UIViewController?
}

extension MapRouter: MapRoutingLogic {
    func routeToAddPin() {
        let controller = AddPinFactory.setup()
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func routeToVisualizePin() {
        
    }
}
