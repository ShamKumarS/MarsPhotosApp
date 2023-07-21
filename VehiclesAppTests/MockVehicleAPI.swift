//
//  MockVehicleAPI.swift
//  VehiclesAppTests
//
//  Created by BrainX IOS Dev on 7/21/23.
//

import XCTest
@testable import VehiclesApp

class MockVehicleAPI: VehicleServiceProtocol {
    
    var loadState: VehiclesAppLoadState?
    let testJSON = """
{
    "photos": [
        {
            "id": 102850,
            "sol": 1000,
            "camera": {
                "id": 21,
                "name": "RHAZ",
                "rover_id": 5,
                "full_name": "Rear Hazard Avoidance Camera"
            },
            "img_src": "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01000/opgs/edr/rcam/RLB_486265291EDR_F0481570RHAZ00323M_.JPG",
            "earth_date": "2015-05-30",
            "rover": {
                "id": 5,
                "name": "Curiosity",
                "landing_date": "2012-08-06",
                "launch_date": "2011-11-26",
                "status": "active",
                "max_sol": 3891,
                "max_date": "2023-07-17",
                "total_photos": 664719,
                "cameras": [{
                    "name": "FHAZ",
                    "full_name": "Front Hazard Avoidance Camera"
                }, {
                    "name": "NAVCAM",
                    "full_name": "Navigation Camera"
                }, {
                    "name": "MAST",
                    "full_name": "Mast Camera"
                }, {
                    "name": "CHEMCAM",
                    "full_name": "Chemistry and Camera Complex"
                }, {
                    "name": "MAHLI",
                    "full_name": "Mars Hand Lens Imager"
                }, {
                    "name": "MARDI",
                    "full_name": "Mars Descent Imager"
                }, {
                    "name": "RHAZ",
                    "full_name": "Rear Hazard Avoidance Camera"
                }]
            }
        }
    ]
}
"""
    
    func getVehicles(with category: String, at pageNumber: Int, completion: @escaping (VehiclesResult) -> Void) {
        switch loadState {
            case .error:
                completion(.failure(.networkError))
            case .empty:
                completion(.success(VehicleResponse(photos: [])))
            default:
                do {
                    let jsonData = Data(testJSON.utf8)
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(VehicleResponse.self, from: jsonData)
                    completion(.success(response))
                } catch {
                    completion(.failure(.invalidData))
                }
        }
        
//        let jsonData = Data(testJSON.utf8)
//        let decoder = JSONDecoder()
//        do {
//            let response = try decoder.decode(VehicleResponse.self, from: jsonData)
//            completion(.success(response))
//        } catch {
//            completion(.failure(.custom(error: error)))
//        }
    }
    
    func getFilteredVehicles(with category: String, cameraType camera: String, at pageNumber: Int, completion: @escaping (VehiclesResult) -> Void) {
        
//        let jsonData = Data(testJSON.utf8)
//        let decoder = JSONDecoder()
//        do {
//            let response = try decoder.decode(VehicleResponse.self, from: jsonData)
//            completion(.success(response))
//        } catch {
//            completion(.failure(.custom(error: error)))
//        }
        
//        switch loadState {
//            case .error:
//                completion(.failure(.networkError))
//            case .empty:
//                completion(.success(VehicleResponse(photos: [])))
//            default:
//                do {
//                    let jsonData = Data(testJSON.utf8)
//                    let decoder = JSONDecoder()
//                    let response = try decoder.decode(VehicleResponse.self, from: jsonData)
//                    completion(.success(response))
//                } catch {
//                    completion(.failure(.invalidData))
//                }
//        }
    }
}
