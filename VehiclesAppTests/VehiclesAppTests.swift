//
//  VehiclesAppTests.swift
//  VehiclesAppTests
//
//  Created by BrainX IOS Dev on 7/18/23.
//

import XCTest
@testable import VehiclesApp

final class VehiclesAppTests: XCTestCase {
   
    // MARK: - Internal Methods
    
    func testVehiclesDataWithEmptyResult() {
        
        let mockAPI = MockVehicleAPI()
        mockAPI.loadState = .empty
        
        let viewModel = VehiclesViewModel(apiService: mockAPI)
        
        viewModel.loadData(for: "curiosity")
        
        XCTAssertTrue(viewModel.photos.isEmpty, "Expected photos to be empty, but received some values")
    }
    
    func testVehiclesDataWithErrorResult() {
        
        let mockAPI = MockVehicleAPI()
        mockAPI.loadState = .error
        
        let viewModel = VehiclesViewModel(apiService: mockAPI)
        
        viewModel.loadData(for: "curiosity")
        
        XCTAssertTrue(viewModel.hasError, "Expected to get an error, but received no error")
    }
    
    func testVehiclesDataWithSuccess() {
        
        let mockAPI = MockVehicleAPI()
        mockAPI.loadState = .finished
        
        let viewModel = VehiclesViewModel(apiService: mockAPI)
        
        viewModel.loadData(for: "curiosity")
        
        XCTAssertTrue(!viewModel.photos.isEmpty, "Expected photos data, but received empty")
    }
}
