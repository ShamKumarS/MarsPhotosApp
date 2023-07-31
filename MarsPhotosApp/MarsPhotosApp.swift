//
//  MarsPhotosApp.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 7/18/23.
//

import SwiftUI

@main
struct MarsPhotosApp: App {
    
    /// For Firebase Integration
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
