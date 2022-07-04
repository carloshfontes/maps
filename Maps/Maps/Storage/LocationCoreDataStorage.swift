//
//  LocationCoreDataStorage.swift
//  Maps
//
//  Created by Carlos Fontes on 04/07/22.
//
import CoreLocation
import CoreData

final class LocationCoreDataStorage: LocationRepository {
    let service: CoreDataManagerProtocol
    
    init(service: CoreDataManagerProtocol = CoreDataStorageManager()) {
        self.service = service
    }
    
    func create(coordinate: CLLocationCoordinate2D) {
        let location = Location(context: service.persistentContainer.viewContext)
        location.latitude = coordinate.latitude
        location.longitude = coordinate.longitude
        location.createdAt = Date()
        service.saveContext()
    }
    
    func fetchAll(completion: (Result<[Location], Error>) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        
        do {
            let fetch = try service.persistentContainer.viewContext.fetch(request)
            guard let locations = fetch as? [Location] else {
                completion(.failure(StorageErrors.fetch))
                return
            }
            
            completion(.success(locations))
        }catch {
            completion(.failure(StorageErrors.fetch))
        }
    }
}
