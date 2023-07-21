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
    @Published var error: NetworkError?
    @Published var hasError = false
    @Published var selectedCamera: CameraType = .none
    @Published var selectedVehicle: Vehicle?
    @Published var isPopupVisible = false
    @Published var isDropdownVisible = false
    @Published private(set) var viewState: VehiclesAppLoadState?
    
    private var currentPage = 1
    private var totalPages = 1
    private let vehicleService: VehicleServiceProtocol
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    // MARK: - Initializer Methods
    
    init(apiService: VehicleServiceProtocol = VehicleService(client: NetworkClient())) {
        vehicleService = apiService
    }
    
    // MARK: - Instance Methods
    
    func shouldLoadMoreData(_ photo: Vehicle) -> Bool {
        photos.last?.id == photo.id
    }
    
    func reset() {
        photos.removeAll()
        currentPage = 1
        totalPages = 1
        viewState = nil
        isPopupVisible = false
        isDropdownVisible = false
    }

    func loadData(for category: String) {
        guard currentPage <= totalPages else { return }
        viewState = photos.isEmpty ? .loading : .fetching
        vehicleService.getVehicles(with: category, at: currentPage) { result in
            switch result {
                case .success(let response):
                    print("Response for \(self.currentPage): \(response.photos.count) \(self.photos.count)")
                    DispatchQueue.main.async {
                        self.viewState = .finished
                        self.photos.append(contentsOf: response.photos)
                        self.totalPages = response.totalPages
                        self.currentPage += 1
                    }
                case .failure(let error):
                    print("Failed due to: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.viewState = .finished
                        self.hasError = true
                        self.error = error
                    }
            }
        }
    }
    
    func loadFilteredData(for category: String) {
        guard currentPage <= totalPages else { return }
        viewState = photos.isEmpty ? .loading : .fetching
        vehicleService.getFilteredVehicles(with: category, cameraType: selectedCamera.rawValue, at: currentPage) { result in
            switch result {
                case .success(let response):
                    print("Response for \(self.currentPage): \(response.photos.count) \(self.photos.count)")
                    DispatchQueue.main.async {
                        self.viewState = .finished
                        self.photos.append(contentsOf: response.photos)
                        self.totalPages = response.totalPages
                        self.currentPage += 1
                    }
                case .failure(let error):
                    print("Failed due to: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.viewState = .finished
                        self.hasError = true
                        self.error = error
                    }
            }
        }
    }
}
