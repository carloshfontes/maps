//
//  MapViewController.swift
//  Maps
//
//  Created by Carlos Fontes on 30/06/22.
//
import UIKit
import MapboxMaps

final class MapViewController: UIViewController {
    private let customView: MapCustomViewConfigurable
    private let router: MapRoutingLogic
    
    init(
        customView: MapCustomViewConfigurable,
        router: MapRoutingLogic
    ) {
        self.customView = customView
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
        customView.delegate = self 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.mapView.location.locationProvider.requestAlwaysAuthorization()
        customView.mapView.location.locationProvider.startUpdatingLocation()
        let centerCoordinate = customView.mapView.cameraState.center
        
        customView.mapView.camera.ease(
            to: CameraOptions(center: centerCoordinate, zoom: 13),
            duration: 1.3
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapViewController: MapBottomSheetViewDelegate {
    func didTapAddPin() {
        router.routeToAddPin()
    }
    
    func didTapVisualizePin() {
        router.routeToVisualizePin()
    }
}
