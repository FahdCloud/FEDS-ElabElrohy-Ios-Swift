//
//  FEDS_Mrwan_HassanApp.swift
//  FEDS-Mrwan-Hassan
//
//  Created by Omar Pakr on 29/08/2024.
//

import SwiftUI
import Firebase
import FirebaseMessaging
import UserNotifications
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
          
          Messaging.messaging().delegate = self
          
          if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
              options: authOptions,
              completionHandler: { _, _ in }
            )
          } else {
            let settings: UIUserNotificationSettings =
              UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
          }

          application.registerForRemoteNotifications()
          UIApplication.shared.applicationIconBadgeNumber = 0
             
         
        return true
      }
        
    
      func application(_ application: UIApplication,
                               didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                               fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
          if [.background, .inactive].contains(application.applicationState) {
              if let messageID = userInfo[gcmMessageIDKey] {
           
                  
              }
              Messaging.messaging().appDidReceiveMessage(userInfo)
              completionHandler(.noData)

              completionHandler(UIBackgroundFetchResult.newData)
                }
          
      }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
                  print("Unable to register for remote notifications: \(error.localizedDescription)")
              }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    didReceive response: UNNotificationResponse,
                                    withCompletionHandler completionHandler: @escaping () -> Void) {
          let userInfo = response.notification.request.content.userInfo


            Messaging.messaging().appDidReceiveMessage(userInfo)

          // With swizzling disabled you must let Messaging know about the message, for Analytics
          // Messaging.messaging().appDidReceiveMessage(userInfo

          completionHandler()
        }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                      -> Void) {
            let userInfo = notification.request.content.userInfo

          // With swizzling disabled you must let Messaging know about the message, for Analytics
           Messaging.messaging().appDidReceiveMessage(userInfo)

          // ...

          // Change this to your preferred presentation option
            if #available(iOS 14.0, *) {
                completionHandler([[.alert, .sound,.badge,.banner]])
            } else {
                // Fallback on earlier versions
            }
        }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
               UserDefaults.standard.set(fcmToken, forKey: "fcmToken")

              let dataDict:[String: String] = ["token": fcmToken ?? ""]
              NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
              // TODO: If necessary send token to application server.
              // Note: This callback is fired at each app startup and whenever a new token is generated.
          }
    
    func application(_ application: UIApplication,
       didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
         Messaging.messaging().apnsToken = deviceToken;
       }
    func applicationWillTerminate(_ application: UIApplication) {
        UserDefaultss().removeObject(forKey: "selectedTag")
    }
}


@available(iOS 16.0, *)
@main
struct FPLS_DevApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var calendarManager = StudentHomeScheduleCalenderView()
    let isDark = UserDefaultss().restoreBool(key: "isDark")
    let fcmToken = UserDefaultss().restoreString(key: "fcmToken")
    

    var body: some Scene {
        WindowGroup {
     
        SplachView()
                    .environmentObject(calendarManager)
                    .preferredColorScheme(isDark ? .dark : .light)
                    .onAppear {
                            UserDefaultss().saveBool(value: false, key: "openFromMyCourses")
                    }
        }
    }
}


//import SwiftUI
////import FirebaseCore
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//
//    return true
//  }
//    func applicationWillTerminate(_ application: UIApplication) {
//        UserDefaultss().removeObject(forKey: "selectedTag")
//    }
//}
//
//
//@available(iOS 16.0, *)
//@main
//struct FPLS_DevApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @StateObject var calendarManager = StudentHomeScheduleCalenderView()
//    let rememberMe : Bool = UserDefaultss().restoreBool(key: "rememberMe")
//    let isParent = UserDefaultss().restoreBool(key: "isParent")
//    let isDark = UserDefaultss().restoreBool(key: "isDark")
//
//    var body: some Scene {
//        WindowGroup {
//
//        SplachView()
//                    .environmentObject(calendarManager)
//                    .preferredColorScheme(isDark ? .dark : .light)
//        }
//    }
//}
