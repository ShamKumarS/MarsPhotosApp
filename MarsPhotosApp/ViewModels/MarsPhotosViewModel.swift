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
    
    private let managedContext = CoreDataManager.shared.managedContext
    
    private var currentPage = 1
    private var totalPages = 1
    private let vehicleService: MarsPhotosServiceProtocol
    private var isInternetAvailable: Bool {
        Reachability.isConnectedToNetwork()
    }
    
    var usClosureApproach = false
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFinished: Bool {
        viewState == .finished
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    // MARK: - Initializer Methods
    
    init(apiService: MarsPhotosServiceProtocol = MarsPhotosService(client: NetworkClient())) {
        vehicleService = apiService
    }
    
    // MARK: - Internal Methods Methods
    
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

    /// Closure approach
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
                            self.totalPages = response.totalPages
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
            /// This approach is for fetching data from core data
            photos = CoreDataManager.shared.fetchData(for: category)
            viewState = .finished
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
                            self.totalPages = response.totalPages
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
            /// This approach is for fetching data from core data
            photos = CoreDataManager.shared.fetchData(for: selectedCamera, and: category)
            viewState = .finished
        }
    }

    // MARK: - Private Methods

    private func loadAndSaveImageDataToLocal() {
        for (index, photo) in photos.enumerated() {
            photo.loadImageData { data in
                DispatchQueue.main.async {
                    guard let data = data,
                          index < self.photos.count else { return }

                    self.photos[index].imageData = data

                    /// Save the updated MarsPhoto entity to Core Data
                    CoreDataManager.shared.saveData(marsPhoto: self.photos[index])
                }
            }
        }
    }
    
    /// Async/Await Approach
    func loadData(for category: String) async {
        if isInternetAvailable {
            guard currentPage <= totalPages else { return }
            viewState = photos.isEmpty ? .loading : .fetching
            
            do {
                let response = try await vehicleService.getPhotos(with: category, at: currentPage)
                photos.append(contentsOf: response.photos)
                totalPages = response.totalPages
                currentPage += 1
                viewState = .finished
                
                await loadAndSaveImageDataToLocal()
            } catch {
                print("Failed due to: \(error.localizedDescription)")
                viewState = .finished
                hasError = true
                self.error = .custom(error: error)
            }
        } else {
            /// This approach is for fetching data from core data
            photos = CoreDataManager.shared.fetchData(for: category)
            viewState = .finished
        }
    }
    
    func loadFilteredData(for category: String) async {
        if isInternetAvailable {
            guard currentPage <= totalPages else { return }
            viewState = photos.isEmpty ? .loading : .fetching
            
            do  {
                let response = try await vehicleService.getPhotos(with: category, cameraType: selectedCamera.rawValue, at: currentPage)
                photos.append(contentsOf: response.photos)
                totalPages = response.totalPages
                currentPage += 1
                viewState = .finished
                
                await loadAndSaveImageDataToLocal()
            } catch {
                print("Failed due to: \(error.localizedDescription)")
                viewState = .finished
                hasError = true
                self.error = .custom(error: error)
            }
        } else {
            /// This approach is for fetching data from core data
            photos = CoreDataManager.shared.fetchData(for: selectedCamera, and: category)
            viewState = .finished
        }
    }
    
    // MARK: - Private Methods
    
    private func loadAndSaveImageDataToLocal() async {
        await withTaskGroup(of: Void.self) { group in
            for (index, photo) in photos.enumerated() {
                group.addTask(priority: .medium) {
                    let data = try? await photo.loadImageData()
                    if let data = data, index < self.photos.count {
                        self.photos[index].imageData = data
//                        try? await CoreDataManager.shared.saveData(marsPhoto: self.photos[index])
                        CoreDataManager.shared.saveData(marsPhoto: self.photos[index])
                    }
                }
            }
        }
    }
}
