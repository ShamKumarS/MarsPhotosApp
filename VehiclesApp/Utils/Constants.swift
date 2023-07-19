//
//  Constants.swift
//  MoviesApp
//
//  Created by BrainX IOS Dev on 6/27/23.
//

import Foundation

struct Constants {
    
    
    struct Urls {
        static func getViehiclesData(with category: String, at currentPage: Int) -> String {
            "https://api.nasa.gov/mars-photos/api/v1/rovers/\(category)/photos?sol=1000&api_key=mGlfgHOAnNbTMwWTqf1t7mK20Nm7eNkz8fWyFjBZ&page=\(currentPage)"
        }
    }
}

enum Tabs: String {
    case curiosity = "Curiosity"
    case opportunity = "Opportunity"
    case spirit = "Spirit"
}

enum CameraType: String, CaseIterable {
    case fhaz, rhaz, mast, chemcam, mahli, mardi, navcam, pancam, minites, none
}
