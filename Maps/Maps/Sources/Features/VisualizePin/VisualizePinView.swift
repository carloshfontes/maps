//
//  VisualizePinView.swift
//  Maps
//
//  Created by Carlos Fontes on 04/07/22.
//
import UIKit
import MapboxMaps

protocol VisualizePinViewConfigurable: UIView {
    var mapView: MapView { get }
    func addAnnotation(by coordinate: CLLocationCoordinate2D) -> PointAnnotation
}

final class VisualizePinView: UIView {
    private let cameraOptions = CameraOptions(
        center: CLLocationCoordinate2D(latitude: -21.2267226, longitude: -47.8609912),
        zoom: 15.5
    )
    
    private lazy var mapOptions = MapInitOptions(
        cameraOptions: cameraOptions,
        styleURI: .outdoors
    )
    
    lazy var mapView: MapView = {
        let view = MapView(frame: .zero, mapInitOptions: mapOptions)
        view.location.options.puckType = .puck2D()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VisualizePinView: VisualizePinViewConfigurable {
    func addAnnotation(by coordinate: CLLocationCoordinate2D) -> PointAnnotation {
        var annotation = PointAnnotation(coordinate: coordinate)
        annotation.image = .init(image: UIImage(named: "red_pin")!, name: "red_pin")
        annotation.iconAnchor = .bottom
        return annotation
    }
}

extension VisualizePinView: ViewCodable {
    func setupHierarchy() {
        addSubview(mapView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
