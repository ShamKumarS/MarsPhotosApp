//
//  MarsPhotos.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 7/17/23.
//

import Foundation

struct MarsPhotos: Codable {
    let photos: [MarsPhoto]
    let totalPages: Int = 10
    
    init(photos: [MarsPhoto]) {
        self.photos = photos
    }
    
    enum CodingKeys: String, CodingKey {
        case photos
    }
}

struct MarsPhoto: Codable, Identifiable {
    let id: Int
    let camera: Camera
    let imgSrc: String
    var imageData: Data?
    let earthDate: String
    let rover: Rover
    
    enum CodingKeys: String, CodingKey {
        case id, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
}

extension MarsPhoto {
    
    func loadImageData(completion: @escaping (Data?) -> Void) {
        guard let imageURL = URL(string: imgSrc) else {
            completion(nil)
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            print("Image Data")
            completion(data)
        }
        .resume()
    }
}

struct Camera: Codable {
    let id: Int
    let name: String
    let roverID: Int
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case roverID = "rover_id"
        case fullName = "full_name"
    }
}

struct Rover: Codable {
    let id: Int
    let name, landingDate, launchDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
    }
}

// This is for storing data in User Default Manager
struct Photo: Codable, Identifiable {
    let id: Int
    var imageData: Data?
    let cameraName: String
    let earthDate: String
    let roverName: String
    let landingDate: String
    let launchDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, imageData, cameraName, earthDate, roverName, landingDate, launchDate
    }
}
