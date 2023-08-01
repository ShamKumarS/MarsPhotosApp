//
//  CameraEntity+CoreDataProperties.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 8/1/23.
//
//

import CoreData
import Foundation

extension CameraEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CameraEntity> {
        return NSFetchRequest<CameraEntity>(entityName: "CameraEntity")
    }
    
    @NSManaged public var fullName: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var roverID: Int32
    
}

// MARK: - CameraEntity Extentions for wrapped value

extension CameraEntity : Identifiable {
    
    public var wrappedName: String {
        name ?? ""
    }
    
    public var wrappedFullName: String {
        fullName ?? ""
    }
}
