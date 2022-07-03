//
//  ViewCodable.swift
//  Maps
//
//  Created by Carlos Fontes on 30/06/22.
//
import Foundation

protocol ViewCodable {
    func setupView()
    func setupConfigurations()
    func setupHierarchy()
    func setupConstraints()
}

extension ViewCodable {
    func setupView() {
        setupConfigurations()
        setupHierarchy()
        setupConstraints()
    }
    
    func setupConfigurations() {}
}
