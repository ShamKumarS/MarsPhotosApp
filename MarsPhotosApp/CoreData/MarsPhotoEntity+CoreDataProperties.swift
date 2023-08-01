//
//  MarsPhotoEntity+CoreDataProperties.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 8/1/23.
//
//

import CoreData
import Foundation

extension MarsPhotoEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MarsPhotoEntity> {
        return NSFetchRequest<MarsPhotoEntity>(entityName: "MarsPhotoEntity")
    }
    
    @NSManaged public var earthDate: String?
    @NSManaged public var id: Int32
    @NSManaged public var imageData: Data?
    @NSManaged public var imageURL: String?
    @NSManaged public var camera: CameraEntity?
    @NSManaged public var rover: RoverEntity?
}

// MARK: - MarsPhotoEntity Extentions for wrapped value

extension MarsPhotoEntity : Identifiable {
    
    public var wrappedEarthDate: String {
        earthDate ?? ""
    }
    
    public var wrappedImageURL: String {
        imageURL ?? ""
    }
    
    public var wrappedImageData: Data {
        imageData ?? Data()
    }
    
    public var wrappedCamera: CameraEntity {
        camera ?? CameraEntity()
    }
    
    public var wrappedRover: RoverEntity {
        rover ?? RoverEntity()
    }
}
