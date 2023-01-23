//
//  AppDelegate + Notifications.swift
//  MarvelApp
//
//  Created by Ali Merhie on 5/31/22.
//

import Foundation
import FirebaseMessaging
import Firebase
extension AppDelegate:  UNUserNotificationCenterDelegate, MessagingDelegate {
    
    @available(iOS 10, *)
    // enable notification in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Perform background operation
        NotificationCenter.default.post(name: .notificationReceived, object: nil)
        // Change this to your preferred presentation option
        completionHandler(UNNotificationPresentationOptions.alert)
    }
    
    // This function will be called right after user tap on the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // tell the app that we have finished processing the user’s action / response
        completionHandler()
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        // Note: This callback is fired at each app startup and whenever a new token is generated.
        print("Firebase registration token: \(fcmToken ?? "")")
        
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        Messaging.messaging().subscribe(toTopic: "ALL"){ error in
            if error == nil{
                print("Subscribed to topic ALL")
            }
            else{
                print("Not Subscribed to topic")
            }
        }
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // Inform the system after the background operation is completed.
        completionHandler(.newData)
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
}
