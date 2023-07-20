//
//  NetworkClient.swift
//  VehiclesApp
//
//  Created by BrainX IOS Dev on 7/19/23.
//

import Foundation

class NetworkClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        let config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
    }
    
    func request<T: Codable>(endPoint: URL?, _ completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let endPoint else {
            completion(.failure(.badRequest))
            return
        }
        
        session.dataTask(with: endPoint) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode(T.self, from: data)
                    
                    completion(.success(object))
                } catch {
                    completion(.failure(.decoding(error)))
                }
            } else if let error = error {
                completion(.failure(.serverError(error)))
            } else {
                completion(.failure(.unknown))
            }
        }.resume()
    }
}
