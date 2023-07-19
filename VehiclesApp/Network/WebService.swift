//
//  WebService.swift
//  MoviesApp
//
//  Created by BrainX IOS Dev on 6/27/23.
//

import Foundation

typealias VehiclesResult = Result<VehicleResponse?, NetworkError>

class WebService {

    private let session: URLSession
    
    init(session: URLSession = .shared) {
        let config = URLSessionConfiguration.default
        self.session = URLSession(configuration: config)
    }
    
    func getVehicles(with category: String, at pageNumber: Int, completion: @escaping (VehiclesResult) -> Void) {

        guard let url = URL(string: Constants.Urls.getViehiclesData(with: category, at: pageNumber)) else {
            completion(.failure(.badURL))
            return
        }

        session.dataTask(with: url) { data, response, error in
            guard let data = data,
                  error == nil else {
                completion(.failure(.noData))
                return
            }

            let vehicles = try? JSONDecoder().decode(VehicleResponse.self, from: data )
            guard let vehicles = vehicles else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(vehicles))
            
        }.resume()
    }
}
