//
//  VehiclesViewModel.swift
//  Vehicles
//
//  Created by BrainX IOS Dev on 7/17/23.
//

import Foundation

class VehiclesViewModel: ObservableObject {
    
    @Published var photos: [Vehicle] = []
    @Published var errorMessage: String? = nil
    @Published var error = false
    
    var currentPage: Int = 1
    var totalPages: Int = 1
    
    func shouldLoadMoreData(_ photo: Vehicle) -> Bool {
        guard let lastIndex = photos.lastIndex(where: { $0.id == photo.id }) else {
            return false
        }
        
        // Check if the current photo is within a certain threshold from the last photo
        let threshold = 3
        return lastIndex >= photos.count - threshold
    }
    
    func loadData(for category: String) {
        guard currentPage <= totalPages else { return }
        WebService().getVehicles(with: category, at: currentPage) { result in
            switch result {
                case .success(let response):
                    print("Response for \(self.currentPage): \(response?.photos.count ?? 0)")
                    print(response?.photos ?? "Empty")
                    DispatchQueue.main.async {
                        if let vehicles = response?.photos {
                            self.photos.append(contentsOf: vehicles)
                        }
                        self.totalPages = response?.totalPages ?? 1
                        self.currentPage += 1
                    }
                case .failure(let error):
                    print("Failed due to: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.error = true
                        self.errorMessage = "Something went wrong. Failed to load the data, try again later."
                    }
            }
        }
    }
}
