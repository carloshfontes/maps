//
//  AddPinViewController.swift
//  Maps
//
//  Created by Carlos Fontes on 03/07/22.
//
import UIKit
import MapboxMaps

final class AddPinViewController: UIViewController {
    private let customView: AddPinViewConfigurable
    
    init(customView: AddPinViewConfigurable) {
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
        customView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let centerCoordinate = customView.mapView.cameraState.center
        customView.mapView.camera.ease(
            to: CameraOptions(center: centerCoordinate, zoom: 13),
            duration: 1.3
        )
                
        customView.mapView.mapboxMap.onEvery(.cameraChanged) { [weak self] _ in
            guard let self = self else { return }
            let coordinate = self.customView.pinCoordinate
            self.customView.updateCoordinate(coordinate)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddPinViewController: PoisitionPinDelegate {
    func didTapAddPin() {
        var pointAnnotation = PointAnnotation(coordinate: customView.pinCoordinate)
        pointAnnotation.image = .init(image: UIImage(named: "red_pin")!, name: "red_pin")
        pointAnnotation.iconAnchor = .bottom
        let pointAnnotationManager = customView.mapView.annotations.makePointAnnotationManager()
        pointAnnotationManager.annotations = [pointAnnotation]
    }
}
