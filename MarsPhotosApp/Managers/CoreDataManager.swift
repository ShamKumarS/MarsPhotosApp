//
//  CoreDataManager.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 7/31/23.
//

import CoreData

class CoreDataManager {
    
    // MARK: - Properties
    
    static let shared = CoreDataManager()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.coreDataModelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext
    
    // MARK: - Internal Methods
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func saveData(marsPhoto: MarsPhoto) {
        guard let imageData = marsPhoto.imageData,
              let id = Int32(exactly: marsPhoto.id) else { return }
        
        /// Check if a MarsPhotoEntity with the same ID already exists
        let fetchRequest: NSFetchRequest<MarsPhotoEntity> = MarsPhotoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let existingPhotos = try managedContext.fetch(fetchRequest)
            if let existingPhoto = existingPhotos.first {
                
                /// MarsPhotoEntity with the same ID already exists, update its properties
                existingPhoto.camera = convertToCameraEntity(marsPhoto.camera)
                existingPhoto.imageURL = marsPhoto.imgSrc
                existingPhoto.imageData = imageData
                existingPhoto.earthDate = marsPhoto.earthDate
                existingPhoto.rover = convertToRoverEntity(marsPhoto.rover)
                
            } else {
                /// MarsPhotoEntity with the ID does not exist, create a new one
                let newPhotoEntity = MarsPhotoEntity(context: managedContext)
                newPhotoEntity.id = id
                newPhotoEntity.camera = convertToCameraEntity(marsPhoto.camera)
                newPhotoEntity.imageURL = marsPhoto.imgSrc
                newPhotoEntity.imageData = imageData
                newPhotoEntity.earthDate = marsPhoto.earthDate
                newPhotoEntity.rover = convertToRoverEntity(marsPhoto.rover)
            }
            
            try managedContext.save()
        } catch {
            print("Error saving data to Core Data: \(error)")
        }
    }

    
    func fetchData(for category: String) -> [MarsPhoto] {
        let fetchRequest: NSFetchRequest<MarsPhotoEntity> = MarsPhotoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "rover.name ==[c] %@", category)
        do {
            let marsPhotoEntities = try managedContext.fetch(fetchRequest)
            return marsPhotoEntities.map { MarsPhoto(entity: $0) }
        } catch {
            print("Error fetching data from Core Data: \(error)")
            return []
        }
    }
    
    func fetchData(for selectedCamera: CameraType, and category: String) -> [MarsPhoto] {
        let fetchRequest: NSFetchRequest<MarsPhotoEntity> = MarsPhotoEntity.fetchRequest()
        
        /// Create predicates for rover.name and camera.name
        let roverPredicate = NSPredicate(format: "rover.name ==[c] %@", category)
        let cameraPredicate = NSPredicate(format: "camera.name ==[c] %@", selectedCamera.rawValue)
        
        /// Combine the predicates using NSCompoundPredicate with AND relationship
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [roverPredicate, cameraPredicate])
        
        fetchRequest.predicate = compoundPredicate
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result.map { MarsPhoto(entity: $0) }
        } catch {
            print("Error fetching data from Core Data: \(error)")
            return []
        }
    }
    
    // MARK: - Private Methods
    
    private func convertToCameraEntity(_ camera: Camera) -> CameraEntity {
        let cameraEntity = CameraEntity(context: managedContext)
        cameraEntity.id = Int32(camera.id)
        cameraEntity.name = camera.name
        cameraEntity.fullName = camera.fullName
        return cameraEntity
    }
    
    private func convertToRoverEntity(_ rover: Rover) -> RoverEntity {
        let roverEntity = RoverEntity(context: managedContext)
        roverEntity.id = Int32(rover.id)
        roverEntity.name = rover.name
        roverEntity.landingDate = rover.landingDate
        roverEntity.launchDate = rover.launchDate
        return roverEntity
    }
}
