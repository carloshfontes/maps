//
//  AddPinView.swift
//  Maps
//
//  Created by Carlos Fontes on 03/07/22.
//
import UIKit
import MapboxMaps

protocol AddPinViewConfigurable: UIView {
    var mapView: MapView { get }
    var delegate: PoisitionPinDelegate? { get set }
    var pinCoordinate: CLLocationCoordinate2D { get }
    func updateCoordinate(_ coordinate: CLLocationCoordinate2D)
}

final class AddPinView: UIView {
    private let resourceOptions = ResourceOptions(accessToken: "pk.eyJ1IjoiY2FybG9zZm9udGVzIiwiYSI6ImNsNTFwYjJkODA3dXIzaWxqdWN0NzY0YWsifQ.qNm5vCkeJNaCa0S8mNhWDA")
    
    private let cameraOptions = CameraOptions(
        center: CLLocationCoordinate2D(latitude: -21.2267226, longitude: -47.8609912),
        zoom: 15.5
    )
    
    private lazy var mapOptions = MapInitOptions(
        resourceOptions: resourceOptions,
        cameraOptions: cameraOptions,
        styleURI: .outdoors
    )

    
    lazy var mapView: MapView = {
        let view = MapView(frame: .zero, mapInitOptions: mapOptions)
        view.location.options.puckType = .puck2D()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var positionPinView: PositionPinViewConfigurable = {
        let view = PositionPinView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let pinImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "red_pin"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var pinCoordinate: CLLocationCoordinate2D {
        mapView.mapboxMap.coordinate(for: pinImageView.center)
    }
    
    var delegate: PoisitionPinDelegate? {
        didSet {
            positionPinView.delegate = delegate
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddPinView: AddPinViewConfigurable {
    func updateCoordinate(_ coordinate: CLLocationCoordinate2D) {
        positionPinView.updateCoordinate(coordinate)
    }
}

extension AddPinView: ViewCodable {
    func setupHierarchy() {
        addSubview(mapView)
        mapView.addSubview(positionPinView)
        mapView.addSubview(pinImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            positionPinView.leadingAnchor.constraint(equalTo: leadingAnchor),
            positionPinView.trailingAnchor.constraint(equalTo: trailingAnchor),
            positionPinView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            pinImageView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor),
            pinImageView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor)
        ])
    }
}