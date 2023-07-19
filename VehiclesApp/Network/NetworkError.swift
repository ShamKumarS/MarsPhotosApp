//
//  NetworkError.swift
//  VehiclesApp
//
//  Created by BrainX IOS Dev on 7/19/23.
//

import Foundation

public enum NetworkErrorA: LocalizedError {
    case badRequest
    case unknown
    case serverError(Error)
    case decoding(Error)
    case custom(String)
}

enum NetworkError: Error {
    case badURL
    case decodingError
    case noData
}
