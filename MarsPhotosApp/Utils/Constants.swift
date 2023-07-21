//
//  Constants.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 6/27/23.
//

import Foundation

struct Constants {
    
    static let apiKey = "mGlfgHOAnNbTMwWTqf1t7mK20Nm7eNkz8fWyFjBZ"
}

enum Tabs: String {
    case curiosity = "Curiosity"
    case opportunity = "Opportunity"
    case spirit = "Spirit"
}

enum CameraType: String, CaseIterable {
    case fhaz, rhaz, mast, chemcam, mahli, mardi, navcam, pancam, minites, none
}

enum VehiclesAppLoadState {
    case empty, fetching, loading, finished, error
}
