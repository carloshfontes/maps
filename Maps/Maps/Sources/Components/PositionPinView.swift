//
//  PositionPinView.swift
//  Maps
//
//  Created by Carlos Fontes on 30/06/22.
//
import UIKit
import CoreLocation

protocol PositionPinViewConfigurable: UIView {
    func updateCoordinate(_ coordinate: CLLocationCoordinate2D)
}

final class PositionPinView: UIView {
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, coordinateLabel])
        view.axis = .vertical
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Posicionar o pin"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coordinateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PositionPinView: PositionPinViewConfigurable {
    func updateCoordinate(_ coordinate: CLLocationCoordinate2D) {
        coordinateLabel.text = "GPS: \(String(format: "%f", coordinate.latitude)), \(String(format: "%f", coordinate.longitude))"
    }
}

extension PositionPinView: ViewCodable {
    func setupConfigurations() {
        backgroundColor = .clear
        contentView.backgroundColor = .white
    }
    
    func setupHierarchy() {
        addSubview(contentView)
        contentView.addSubview(contentStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
