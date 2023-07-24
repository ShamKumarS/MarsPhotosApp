//
//  MarsPhotosAppTests.swift
//  MarsPhotosAppTests
//
//  Created by BrainX IOS Dev on 7/18/23.
//

import Combine
import XCTest
@testable import MarsPhotosApp

final class MarsPhotosAppTests: XCTestCase {
   
    // MARK: - Instance Properties
    
    private var cancellables = Set<AnyCancellable>()
    var viewModel: MarsPhotosViewModel!
    var mockAPI: MockMarsPhotosAPI!
    
    // MARK: - Overridden Methods
    
    override func setUp() {
        super.setUp()
        mockAPI = MockMarsPhotosAPI()
        viewModel = MarsPhotosViewModel(apiService: mockAPI)
    }
    
    // MARK: - Internal Methods
    
    func testVehiclesDataWithEmptyResult() {
        let expectation = expectation(description: "Testing empty state with mock api")
        mockAPI.loadState = .empty
        viewModel.loadData(for: "curiosity")
        viewModel.$photos
            .receive(on: RunLoop.main)
            .sink { photos in
                XCTAssertTrue(photos.isEmpty, "Expected photos to be empty, but received some values")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }
    
    func testVehiclesDataWithErrorResult() {
        let expectation = expectation(description: "Testing error state with mock api")
        mockAPI.loadState = .error
        viewModel.loadData(for: "curiosity")
        viewModel.$hasError
            .receive(on: RunLoop.main)
            .sink { error in
                XCTAssertNotNil(error, "Expected to get an error, but received no error")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }
    
    func testVehiclesDataWithSuccess() {
        let expectation = expectation(description: "Testing finish state with mock api")
        mockAPI.loadState = .finished
        viewModel.loadData(for: "curiosity")
        viewModel.$photos
            .receive(on: RunLoop.main)
            .sink { photos in
                XCTAssertTrue(photos.isEmpty, "Expected photos data, but received empty")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }
}
