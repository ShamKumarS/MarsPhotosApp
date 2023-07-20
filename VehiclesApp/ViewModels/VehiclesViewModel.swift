//
//  VehiclesViewModel.swift
//  Vehicles
//
//  Created by BrainX IOS Dev on 7/17/23.
//

import Foundation

class VehiclesViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var photos: [Vehicle] = []
    @Published var errorMessage: String? = nil
    @Published var error = false
    @Published var selectedCamera: CameraType = .none
    @Published var isDropdownVisible: Bool = false
    @Published var selectedVehicle: Vehicle?
    @Published var isPopupVisible: Bool = false
    
    var currentPage: Int = 1
    var totalPages: Int = 1
    let vehicleService: VehicleServiceType!
    
    // MARK: - Initializer Methods
    
    init() {
        vehicleService = VehicleService(client: NetworkClient())
    }
    
    // MARK: - Instance Methods
    
    func shouldLoadMoreData(_ photo: Vehicle) -> Bool {
        guard let lastIndex = photos.lastIndex(where: { $0.id == photo.id }) else {
            return false
        }
        
        // Check if the current photo is within a certain threshold from the last photo
        let threshold = 3
        return lastIndex >= photos.count - threshold
    }
    
    func loadData() {
        if selectedCamera == .none {
            
        }
    }
    
    func loadData(for category: String) {
        guard currentPage <= totalPages else { return }
        vehicleService.getVehicles(with: category, at: currentPage) { result in
            switch result {
                case .success(let response):
                    print("Response for \(self.currentPage): \(response.photos.count)")
                    print(response.photos)
                    DispatchQueue.main.async {
                        self.photos.append(contentsOf: response.photos)
                        self.totalPages = response.totalPages
                        self.currentPage += 1
                    }
                case .failure(let error):
                    print("Failed due to: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.error = true
                        self.errorMessage = LocalizedKey.networkErrorMessage.string
                    }
            }
        }
    }
    
    func loadFilteredData(for category: String) {
        photos.removeAll()
//        guard currentPage <= totalPages else { return }
        vehicleService.getFilteredVehicles(with: category, cameraType: selectedCamera.rawValue, at: 1) { result in
            switch result {
                case .success(let response):
                    print("Response for \(self.currentPage): \(response.photos.count)")
                    print(response.photos)
                    DispatchQueue.main.async {
                        self.photos.append(contentsOf: response.photos)
                        self.totalPages = response.totalPages
                        self.currentPage += 1
                    }
                case .failure(let error):
                    print("Failed due to: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.error = true
                        self.errorMessage = LocalizedKey.networkErrorMessage.string
                    }
            }
        }
    }
}
