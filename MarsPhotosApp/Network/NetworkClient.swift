//
//  NetworkClient.swift
//  MarsPhotosApp
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
    
    /// Closure approach
    func request<T: Codable>(endPoint: URL?, _ completion: @escaping (Result<T, NetworkError>) -> Void) {

        guard let endPoint else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }

        session.dataTask(with: endPoint) { data, response, error in

            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkError.invalidStatusCode(statusCode: statusCode)))
                return
            }

            guard let data else {
                completion(.failure(NetworkError.custom(error: error!)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(NetworkError.failedToDecode(error: error)))
            }

        }.resume()
    }
    
    /// Async/Await approach
    func request<T: Codable>(endPoint: URL?) async throws -> T {
        guard let endPoint else { throw NetworkError.invalidUrl }
        
        let (data, response) = try await URLSession.shared.data(from: endPoint)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...300) ~= httpResponse.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkError.invalidStatusCode(statusCode: statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            throw NetworkError.failedToDecode(error: error)
        }
    }
}
