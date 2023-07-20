//
//  BaseService.swift
//  VehiclesApp
//
//  Created by BrainX IOS Dev on 7/19/23.
//

import Foundation

class BaseService {
    
    // MARK: - Properties
    
    let client: NetworkClient
    
    // MARK: - Initializer Methods
    
    init(client: NetworkClient) {
        self.client = client
    }
}
