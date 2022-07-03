//
//  MapFactory.swift
//  Maps
//
//  Created by Carlos Fontes on 30/06/22.
//
import UIKit.UIViewController

final  class MapFactory {
    static func setup() -> UIViewController {
        let view: MapCustomViewConfigurable = MapCustomView()
        var router: MapRoutingLogic = MapRouter()
        let controller = MapViewController(customView: view, router: router)
        router.viewController = controller
        return controller
    }
}
