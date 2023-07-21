//
//  LocalizedKey.swift
//  VehiclesApp
//
//  Created by BrainX IOS Dev on 7/20/23.
//

import Foundation

enum LocalizedKey: String {
    
    // MARK: - Internal Properties
    
    var string: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
    
    // MARK: - Enum cases
    
    case ok
    case alert
    case dateTaken
    case vehicle
    case launchDate
    case landingDate
    case networkErrorMessage
    case loading
}
