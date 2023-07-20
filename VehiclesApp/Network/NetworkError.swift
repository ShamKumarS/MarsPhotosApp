//
//  NetworkError.swift
//  VehiclesApp
//
//  Created by BrainX IOS Dev on 7/19/23.
//

import Foundation

public enum NetworkError: LocalizedError {
    case badRequest
    case unknown
    case serverError(Error)
    case decoding(Error)
    case custom(String)
}
