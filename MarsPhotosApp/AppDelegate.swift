//
//  AppDelegate.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 7/24/23.
//

import Firebase
import UIKit
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Internal Properties

    var window: UIWindow?
    var orientationLock  = UIInterfaceOrientationMask.portrait

    // MARK: - Internal Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.overrideUserInterfaceStyle = .light
//        FirebaseApp.configure()
        setupRemoteNotification()
        
        if let _ = launchOptions?[.remoteNotification] as? [String: AnyObject] {
            /// Launching from a notification provides an opportunity to handle the notification payload and take appropriate actions based on the notification content.
        }
        
        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }

    // MARK: - Private Methods

    private func setupRemoteNotification() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
}

// MARK: - UNUserNotificationCenterDelegate Methods

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        /// Called when the app successfully registers for remote notifications. The deviceToken parameter contains the device-specific token that the app will use to receive remote notifications from the server.
        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        UserDefaultManager.deviceToken = tokenString
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        /// Handle app failure to register for remote notifications due to an error
        print(error.localizedDescription)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        /// Notification is about to be presented to the user while the app is running in the foreground
        /// Customize the presentation of the notification
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        /// Called when the user taps on a notification while the app is running or in the background. It is used to handle user interactions with the notification.
        NotificationCenter.default.post(name: .receivedNotification, object: nil)
    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        /// Called when the app receives a remote notification while it is running in the foreground or background. The userInfo parameter contains the payload of the notification.
        NotificationCenter.default.post(name: .receivedNotification, object: nil)
    }
}
