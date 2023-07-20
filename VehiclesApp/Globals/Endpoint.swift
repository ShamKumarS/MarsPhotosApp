//
//  Endpoint.swift
//  VehiclesApp
//
//  Created by BrainX IOS Dev on 7/19/23.
//

import Foundation

struct Endpoint {

    static var getCategoryData: (String, Int) -> URL? = {
        URL(string: "\($0)/photos?sol=1000&api_key=\(Constants.apiKey)&page=\($1)", relativeTo: DevelopmentEnvironment.baseUrl)
    }
    
    static var getCameraType: (String, String, Int) -> URL? = {
        URL(string: "\($0)/photos?sol=1000&api_key=\(Constants.apiKey)&camera=\($1)&page=\($2)", relativeTo: DevelopmentEnvironment.baseUrl)
    }
}
