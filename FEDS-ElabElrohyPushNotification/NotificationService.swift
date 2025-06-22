//
//  NotificationService.swift
//  FEDS-Mrwan-HassanPushNotification
//
//  Created by Omar Pakr on 29/08/2024.
//

import UserNotifications
import UIKit
import Foundation


class NotificationService: UNNotificationServiceExtension {
    var contentHandler: ((UNNotificationContent) -> Void)?
      var bestAttemptContent: UNMutableNotificationContent?

      override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
          self.contentHandler = contentHandler
          bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

          if let bestAttemptContent = bestAttemptContent {
              let apsData = request.content.userInfo["aps"] as! [String : Any]
              let alertData = apsData["alert"] as! [String : Any]
              let imageData = request.content.userInfo["fcm_options"] as! [String : Any]
              bestAttemptContent.title = (alertData["title"] as? String) ?? ""
              bestAttemptContent.body = (alertData["body"] as? String) ?? ""

              guard let urlImageString = imageData["image"] as? String else {
                  contentHandler(bestAttemptContent)
                  return
              }
              if let notificationImageUrl = URL(string: urlImageString) {

                  guard let imageData = try? Data(contentsOf: notificationImageUrl) else {
                      contentHandler(bestAttemptContent)
                      return
                  }
                  guard let attachment = UNNotificationAttachment.saveImageToDisk(fileIdentifier: "notificationImage.jpg", data: imageData, options: nil) else {
                      contentHandler(bestAttemptContent)
                      return
                  }
                  bestAttemptContent.attachments = [ attachment ]
              }
//              Messaging.serviceExtension().populateNotificationContent(self.bestAttemptContent!, withContentHandler: contentHandler)
          }
      }
    override func serviceExtensionTimeWillExpire() {
          // Called just before the extension will be terminated by the system.
          // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
          if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
              contentHandler(bestAttemptContent)
          }
      }
}

//MARK: Extension for Notification Attachment
extension UNNotificationAttachment {

    static func saveImageToDisk(fileIdentifier: String, data: Data, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
        let fileManager = FileManager.default
        let folderName = ProcessInfo.processInfo.globallyUniqueString
        let folderURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(folderName, isDirectory: true)

        do {
            try fileManager.createDirectory(at: folderURL!, withIntermediateDirectories: true, attributes: nil)
            let fileURL = folderURL?.appendingPathComponent(fileIdentifier)
            try data.write(to: fileURL!, options: [])
            let attachment = try UNNotificationAttachment(identifier: fileIdentifier, url: fileURL!, options: options)
            return attachment
        } catch let error {
            print("error \(error)")
        }
        return nil
    }
}

