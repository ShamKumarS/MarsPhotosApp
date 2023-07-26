//
//  MarsPhotosDataManager.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 7/24/23.
//

import SwiftUI

class MarsPhotosDataManager: ObservableObject {
    
    func saveDataToUserDefaults(photos: [MarsPhoto]) {
        do {
            let photos = mapMarsPhotosToPhotos(marsPhotos: photos)
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(photos)
            UserDefaults.standard.set(encodedData, forKey: "marsPhotosData")
            print("Saved successfully in default manager.")
        } catch {
            print("Failed to encode.")
        }
    }
    
    func loadDataFromUserDefaults() -> [MarsPhoto] {
        guard let data = UserDefaults.standard.data(forKey: "marsPhotosData") else {
            print("Unable to load it from user defaults.")
            return []
        }
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([Photo].self, from: data)
            let photos = mapPhotosToMarsPhotos(photos: decodedData)
            return photos
        } catch {
            print("Failed to decode.")
            return []
        }
    }
    
    func clearData() {
        UserDefaults.standard.removeObject(forKey: "marsPhotosData")
    }
    
    func mapMarsPhotosToPhotos(marsPhotos: [MarsPhoto]) -> [Photo] {
        var photos: [Photo] = []
        
        for marsPhoto in marsPhotos {
            guard (marsPhoto.imageData != nil) else { continue }
            let photo = Photo(
                id: marsPhoto.id,
                imageData: marsPhoto.imageData,
                cameraName: marsPhoto.camera.name,
                earthDate: marsPhoto.earthDate,
                roverName: marsPhoto.rover.name,
                landingDate: marsPhoto.rover.landingDate,
                launchDate: marsPhoto.rover.launchDate
            )
            photos.append(photo)
        }
        
        return photos
    }
    
    func mapPhotosToMarsPhotos(photos: [Photo]) -> [MarsPhoto] {
        var marsPhotos: [MarsPhoto] = []
        
        for photo in photos {
            let marsPhoto = MarsPhoto(
                id: photo.id,
                camera: Camera(
                    id: 0,
                    name: photo.cameraName,
                    roverID: 0,
                    fullName: ""
                ),
                imgSrc: "",
                imageData: photo.imageData,
                earthDate: photo.earthDate,
                rover: Rover(
                    id: 0,
                    name: photo.roverName,
                    landingDate: photo.landingDate,
                    launchDate: photo.launchDate
                )
            )
            marsPhotos.append(marsPhoto)
        }
        
        return marsPhotos
    }
}
