//
//  MarsPhotosViewModel.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 7/17/23.
//

import Foundation

class MarsPhotosViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var photos: [MarsPhoto] = []
    @Published var error: NetworkError?
    @Published var hasError = false
    @Published var selectedCamera: CameraType = .none
    @Published var selectedVehicle: MarsPhoto?
    @Published var isPopupVisible = false
    @Published var isDropdownVisible = false
    @Published var viewState: VehiclesAppLoadState?
    
    private var currentPage = 1
    private var totalPages = 1
    private let vehicleService: MarsPhotosServiceProtocol
    private let dataManager: MarsPhotosDataManager
    private var isInternetAvailable: Bool {
        Reachability.isConnectedToNetwork()
    }
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    // MARK: - Initializer Methods
    
    init(apiService: MarsPhotosServiceProtocol = MarsPhotosService(client: NetworkClient())) {
        vehicleService = apiService
        dataManager = MarsPhotosDataManager()
    }
    
    // MARK: - Instance Methods
    
    func shouldLoadMoreData(_ photo: MarsPhoto) -> Bool {
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
        if isInternetAvailable {
            guard currentPage <= totalPages else { return }
            viewState = photos.isEmpty ? .loading : .fetching
            vehicleService.getPhotos(with: category, at: currentPage) { result in
                switch result {
                    case .success(let response):
                        print("Response for \(self.currentPage): \(response.photos.count) \(self.photos.count)")
                        DispatchQueue.main.async {
                            self.viewState = .finished
                            self.photos.append(contentsOf: response.photos)
//                            self.totalPages = response.totalPages
                            self.currentPage += 1
                            self.loadAndSaveImageDataToLocal()
                        }
                    case .failure(let error):
                        print("Failed due to: \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            self.viewState = .finished
                            self.hasError = true
                            self.error = .custom(error: error)
                        }
                }
            }
        } else {
            let savedPhotos = dataManager.loadDataFromUserDefaults()
            photos = savedPhotos.filter { $0.rover.name.uppercased() == category.uppercased() }
        }
    }
    
    func loadFilteredData(for category: String) {
        if isInternetAvailable {
            guard currentPage <= totalPages else { return }
            viewState = photos.isEmpty ? .loading : .fetching
            vehicleService.getPhotos(with: category, cameraType: selectedCamera.rawValue, at: currentPage) { result in
                switch result {
                    case .success(let response):
                        print("Response for \(self.currentPage): \(response.photos.count) \(self.photos.count)")
                        DispatchQueue.main.async {
                            self.viewState = .finished
                            self.photos.append(contentsOf: response.photos)
//                            self.totalPages = response.totalPages
                            self.currentPage += 1
                            self.loadAndSaveImageDataToLocal()
                        }
                    case .failure(let error):
                        print("Failed due to: \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            self.viewState = .finished
                            self.hasError = true
                            self.error = .custom(error: error)
                        }
                }
            }
        } else {
            let savedPhotos = dataManager.loadDataFromUserDefaults()
            photos = savedPhotos.filter { $0.camera.name.uppercased() == selectedCamera.rawValue.uppercased() }
        }
    }
    
    func loadAndSaveImageDataToLocal() {
        for (index, photo) in photos.enumerated() {
            photo.loadImageData { data in
                DispatchQueue.main.async {
                    if let data = data {
                        self.photos[index].imageData = data
                        self.dataManager.saveDataToUserDefaults(photos: self.photos)
                    }
                }
            }
        }
    }
}
