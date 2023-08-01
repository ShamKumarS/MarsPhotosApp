//
//  RoverEntity+CoreDataProperties.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 8/1/23.
//
//

import CoreData
import Foundation

extension RoverEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoverEntity> {
        return NSFetchRequest<RoverEntity>(entityName: "RoverEntity")
    }
    
    @NSManaged public var id: Int32
    @NSManaged public var landingDate: String?
    @NSManaged public var launchDate: String?
    @NSManaged public var name: String?
    
}

// MARK: - RoverEntity Extentions for wrapped value

extension RoverEntity : Identifiable {
    
    public var wrappedName: String {
        name ?? ""
    }
    
    public var wrappedLandingDate: String {
        landingDate ?? ""
    }
    
    public var wrappedLaunchDate: String {
        launchDate ?? ""
    }
}
