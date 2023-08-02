//
//  UserDefaultManager.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 7/24/23.
//

import SwiftUI

class UserDefaultManager {
    
    @AppStorage("device_token") static var deviceToken: String = ""
}
