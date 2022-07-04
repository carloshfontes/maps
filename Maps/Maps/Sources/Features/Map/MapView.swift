//
//  MapView.swift
//  Maps
//
//  Created by Carlos Fontes on 30/06/22.
//
import UIKit
import MapboxMaps

protocol MapCustomViewConfigurable: UIView {
    var delegate: MapBottomSheetViewDelegate? { get set }
    var mapView: MapView { get }
}

final class MapCustomView: UIView, MapCustomViewConfigurable {
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
    
    private lazy var sheetView: MapBottomSheetViewConfigurable = {
        let view = MapBottomSheetView()
        view.translatesAutoresizingMaskIntoConstraints = false 
        return view
    }()
    
    var delegate: MapBottomSheetViewDelegate? {
        didSet {
            sheetView.delegate = delegate
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

extension MapCustomView: ViewCodable {
    func setupHierarchy() {
        addSubview(mapView)
        addSubview(sheetView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            sheetView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sheetView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sheetView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
