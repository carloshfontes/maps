//
//  AddPinFactory.swift
//  Maps
//
//  Created by Carlos Fontes on 03/07/22.
//
import UIKit.UIViewController

final class AddPinFactory {
    static func setup() -> UIViewController {
        let view: AddPinViewConfigurable = AddPinView()
        let controller = AddPinViewController(customView: view)
        return controller
    }
}
