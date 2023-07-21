//
//  NetworkError.swift
//  VehiclesApp
//
//  Created by BrainX IOS Dev on 7/19/23.
//

import Foundation

enum NetworkError: LocalizedError {
    
    case invalidUrl
    case custom(error: Error)
    case invalidStatusCode(statusCode: Int)
    case invalidData
    case failedToDecode(error: Error)
    case networkError
    
    public var errorDescription: String {
        switch self {
            case .invalidUrl:
                return "URL isn't valid"
            case .invalidStatusCode:
                return "Status code falls into the wrong range"
            case .invalidData:
                return "Response data is invalid"
            case .failedToDecode(let err):
                return "Failed to decode \(err.localizedDescription)"
            case .custom(let err):
                return "Something went wrong \(err.localizedDescription)"
            case .networkError:
                return "Something went wrong. Failed to load the data, try again later."
        }
    }
}
