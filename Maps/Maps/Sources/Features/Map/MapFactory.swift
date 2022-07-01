//
//  MapFactory.swift
//  Maps
//
//  Created by Carlos Fontes on 30/06/22.
//
import UIKit.UIViewController

final  class MapFactory {
    static func setup() -> UIViewController {
        let controller = MapViewController()
        return controller
    }
}
