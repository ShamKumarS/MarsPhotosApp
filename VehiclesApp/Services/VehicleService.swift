//
//  WebService.swift
//  MoviesApp
//
//  Created by BrainX IOS Dev on 6/27/23.
//

import Foundation

typealias VehiclesResult = Result<VehicleResponse, NetworkError>

protocol VehicleServiceType {
    
    func getVehicles(with category: String, at pageNumber: Int, completion: @escaping (VehiclesResult) -> Void)
    func getFilteredVehicles(with category: String, cameraType camera: String, at pageNumber: Int, completion: @escaping (VehiclesResult) -> Void)
}

class VehicleService: BaseService, VehicleServiceType {
    
    // MARK: - Initializer Methods
    
    override init(client: NetworkClient) {
        super.init(client: client)
    }
    
    // MARK: - Instance Methods
    
    func getVehicles(with category: String, at pageNumber: Int, completion: @escaping (VehiclesResult) -> Void) {
        let endPoint = Endpoint.getCategoryData(category, pageNumber)
        client.request(endPoint: endPoint, completion)
    }
    
    func getFilteredVehicles(with category: String, cameraType camera: String, at pageNumber: Int, completion: @escaping (VehiclesResult) -> Void) {
        let endPoint = Endpoint.getCameraType(category, camera, pageNumber)
        client.request(endPoint: endPoint, completion)
    }
}
