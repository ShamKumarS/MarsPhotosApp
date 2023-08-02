//
//  MarsPhotos.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 7/17/23.
//

import Foundation

struct MarsPhotos: Codable {
    
    let photos: [MarsPhoto]
    let totalPages: Int = 100 // as the api does not contain total pages so for it is used as a static
    
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
    
    init(entity: MarsPhotoEntity) {
        id = Int(entity.id)
        camera = Camera(entity: entity.wrappedCamera)
        imgSrc = entity.wrappedImageURL
        imageData = entity.imageData
        earthDate = entity.wrappedEarthDate
        rover = Rover(entity: entity.wrappedRover)
    }
}

extension MarsPhoto {
    
    func loadImageData(completion: @escaping (Data?) -> Void) {
        guard let imageURL = URL(string: imgSrc) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, _ in
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
    
    init(entity: CameraEntity) {
        id = Int(entity.id)
        name = entity.wrappedName
        roverID = Int(entity.roverID)
        fullName = entity.wrappedFullName
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
    
    init(entity: RoverEntity) {
        id = Int(entity.id)
        name = entity.wrappedName
        landingDate = entity.wrappedLandingDate
        launchDate = entity.wrappedLaunchDate
    }
}
