//
//  VisualizePinViewController.swift
//  Maps
//
//  Created by Carlos Fontes on 04/07/22.
//
import UIKit
import MapboxMaps

protocol VisualizePinDisplayLogic: AnyObject {
    func displayLocations(_ locations: [Location])
}

final class VisualizePinViewController: UIViewController {
    private let customView: VisualizePinViewConfigurable
    private let interactor: VisualizePinBusinessLogic
    private lazy var pointAnnotationManager = customView.mapView.annotations.makePointAnnotationManager()

    
    init(
        customView: VisualizePinViewConfigurable,
        interactor: VisualizePinBusinessLogic
    ) {
        self.customView = customView
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let centerCoordinate = customView.mapView.cameraState.center
        customView.mapView.camera.ease(
            to: CameraOptions(center: centerCoordinate, zoom: 13),
            duration: 1.3
        )
        
        interactor.fetchLocations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VisualizePinViewController: VisualizePinDisplayLogic {
    func displayLocations(_ locations: [Location]) {
        locations.forEach { location in
            let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let annotation = customView.addAnnotation(by: coordinate)
            pointAnnotationManager.annotations.append(annotation)
        }
        
    }
}
