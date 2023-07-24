//
//  NSNotification.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 7/24/23.
//

import Foundation

extension NSNotification.Name {
    
    // MARK: - Static Properties
    
    static let sessionExpired = NSNotification.Name(rawValue:"sessionExpiredNotification")
    static let receivedNotification = NSNotification.Name(rawValue:"receivedNotification")
    static let updateNotificationIcon = NSNotification.Name(rawValue:"updateNotificationIcon")
}
