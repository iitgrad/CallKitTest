//
//  CallKitTestApp.swift
//  CallKitTest
//
//  Created by Kevin McQuown on 5/6/21.
//

import SwiftUI
import CloudKit
import AppDevWithSwiftLibrary

@main
struct CallKitTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        CloudKitSupport.initializeContainer(name: "iCloud.com.mayo.arti.EHealthMobile")
        application.registerForRemoteNotifications()
        return true
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("got notification")
        if let notification = CKNotification(fromRemoteNotificationDictionary: userInfo) {
            print("CloudKit database changed \(notification.subscriptionID ?? "None provided")")
            print(userInfo.description)

            NotificationCenter.default.post(name: NSNotification.Name.CKAccountChanged, object: nil)
            completionHandler(.newData)
        }
    }
}
