//
//  MarsPhotosAppTests.swift
//  MarsPhotosAppTests
//
//  Created by BrainX IOS Dev on 7/18/23.
//

import XCTest
@testable import MarsPhotosApp

final class MarsPhotosAppTests: XCTestCase {
   
    // MARK: - Internal Methods
    
    func testVehiclesDataWithEmptyResult() {
        
        let mockAPI = MockMarsPhotosAPI()
        mockAPI.loadState = .empty
        
        let viewModel = MarsPhotosViewModel(apiService: mockAPI)
        
        viewModel.loadData(for: "curiosity")
        
        XCTAssertTrue(viewModel.photos.isEmpty, "Expected photos to be empty, but received some values")
    }
    
    func testVehiclesDataWithErrorResult() {
        
        let mockAPI = MockMarsPhotosAPI()
        mockAPI.loadState = .error
        
        let viewModel = MarsPhotosViewModel(apiService: mockAPI)
        
        viewModel.loadData(for: "curiosity")
        
        XCTAssertTrue(viewModel.hasError, "Expected to get an error, but received no error")
    }
    
    func testVehiclesDataWithSuccess() {
        
        let mockAPI = MockMarsPhotosAPI()
        mockAPI.loadState = .finished
        
        let viewModel = MarsPhotosViewModel(apiService: mockAPI)
        
        viewModel.loadData(for: "curiosity")
        
        XCTAssertTrue(!viewModel.photos.isEmpty, "Expected photos data, but received empty")
    }
}
