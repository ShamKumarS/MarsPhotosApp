//
//  MarsPhotosResult.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 6/27/23.
//

import Foundation

typealias MarsPhotosResult = Result<MarsPhotos, NetworkError>

protocol MarsPhotosServiceProtocol {
    
    /// Closure approach
    func getPhotos(with category: String, at pageNumber: Int, completion: @escaping (MarsPhotosResult) -> Void)
    func getPhotos(with category: String, cameraType camera: String, at pageNumber: Int, completion: @escaping (MarsPhotosResult) -> Void)
    
    /// Async/Await Approach
    func getPhotos(with category: String, at pageNumber: Int) async throws -> MarsPhotos
    func getPhotos(with category: String, cameraType camera: String, at pageNumber: Int) async throws -> MarsPhotos
}

class MarsPhotosService: BaseService, MarsPhotosServiceProtocol {
    
    // MARK: - Initializer Methods
    
    override init(client: NetworkClient) {
        super.init(client: client)
    }
    
    // MARK: - Instance Methods
    
    /// Closure approach
    func getPhotos(with category: String, at pageNumber: Int, completion: @escaping (MarsPhotosResult) -> Void) {
        let endPoint = Endpoint.getCategoryData(category, pageNumber)
        client.request(endPoint: endPoint, completion)
    }

    func getPhotos(with category: String, cameraType camera: String, at pageNumber: Int, completion: @escaping (MarsPhotosResult) -> Void) {
        let endPoint = Endpoint.getCameraType(category, camera, pageNumber)
        client.request(endPoint: endPoint, completion)
    }
    
    /// Async/Await Approach
    func getPhotos(with category: String, at pageNumber: Int) async throws -> MarsPhotos {
        let endPoint = Endpoint.getCategoryData(category, pageNumber)
        return try await client.request(endPoint: endPoint)
    }
    
    func getPhotos(with category: String, cameraType camera: String, at pageNumber: Int) async throws -> MarsPhotos {
        let endPoint = Endpoint.getCameraType(category, camera, pageNumber)
        return try await client.request(endPoint: endPoint)
    }
}
