//
//  MapViewController.swift
//  Maps
//
//  Created by Carlos Fontes on 30/06/22.
//
import UIKit
import MapboxMaps

protocol MapDisplayLogic: AnyObject {
    
}

final class MapViewController: UIViewController {
    private let customView: MapCustomViewConfigurable
    private var pointAnnotationManager: PointAnnotationManager?
    
    init(customView: MapCustomViewConfigurable) {
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.mapView.location.delegate = self
        customView.mapView.location.locationProvider.requestAlwaysAuthorization()
        customView.mapView.location.locationProvider.startUpdatingLocation()
                
    
        
        let centerCoordinate = customView.mapView.cameraState.center
        customView.mapView.camera.ease(to: CameraOptions(center: centerCoordinate, zoom: 13), duration: 1.3)
                
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

extension MapViewController: LocationPermissionsDelegate {
    
}
