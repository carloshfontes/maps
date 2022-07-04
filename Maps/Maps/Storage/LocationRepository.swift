//
//  LocationRepository.swift
//  Maps
//
//  Created by Carlos Fontes on 04/07/22.
//
import Foundation
import CoreLocation

protocol LocationRepository {
    func create(coordinate: CLLocationCoordinate2D)
    func fetchAll(completion: (Result<[Location], Error>) -> Void)
}
