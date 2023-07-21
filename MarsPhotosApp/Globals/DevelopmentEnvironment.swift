//
//  DevelopmentEnvironment.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 7/19/23.
//

import Foundation

enum DevelopmentEnvironment {

    case development
    case staging
    case production

    static var current: DevelopmentEnvironment { .development }

    static var baseUrl: URL? {
        switch current {
        case .development:
            return URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/")
        case .staging:
            return URL(string: "staging_url")
        case .production:
            return URL(string: "production_url")
        }
    }
}
