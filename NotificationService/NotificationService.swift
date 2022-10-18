//
//  NotificationService.swift
//  NotificationService
//
//  Created by Teenanath on 14/04/22.
//

import UserNotifications
import AVFoundation

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        print("service extention call")
        
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...

            if let userDefaults = UserDefaults(suiteName: "group.com.Gobbly.appGroup") {
                let value = userDefaults.value(forKey: "SOUND_VALUE") as! String

                let systemSoundID: SystemSoundID = SystemSoundID(value) ?? 0
                // to play sound
                AudioServicesPlaySystemSound(systemSoundID)
            }
            bestAttemptContent.body = "Prativvha"
            bestAttemptContent.subtitle = "Aarav"
            bestAttemptContent.title = "Sunil"//"\(bestAttemptContent.title) [modified]"
            bestAttemptContent.sound = nil
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
