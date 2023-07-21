//
//  MarsPhotosResult.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 6/27/23.
//

import Foundation

typealias MarsPhotosResult = Result<MarsPhotos, NetworkError>

protocol MarsPhotosServiceProtocol {
    
    func getPhotos(with category: String, at pageNumber: Int, completion: @escaping (MarsPhotosResult) -> Void)
    func getPhotos(with category: String, cameraType camera: String, at pageNumber: Int, completion: @escaping (MarsPhotosResult) -> Void)
}

class MarsPhotosService: BaseService, MarsPhotosServiceProtocol {
    
    // MARK: - Initializer Methods
    
    override init(client: NetworkClient) {
        super.init(client: client)
    }
    
    // MARK: - Instance Methods
    
    func getPhotos(with category: String, at pageNumber: Int, completion: @escaping (MarsPhotosResult) -> Void) {
        let endPoint = Endpoint.getCategoryData(category, pageNumber)
        client.request(endPoint: endPoint, completion)
    }
    
    func getPhotos(with category: String, cameraType camera: String, at pageNumber: Int, completion: @escaping (MarsPhotosResult) -> Void) {
        let endPoint = Endpoint.getCameraType(category, camera, pageNumber)
        client.request(endPoint: endPoint, completion)
    }
}
