//
//  NotificationHandler.swift
//  Covid Pilot
//
//  Created by alopezh on 02/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    
    private let formatter: DateFormatter = DateFormatter()

    func setupNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        let options: UNAuthorizationOptions = [.alert, .sound]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
    func scheduleNotification(title: String, body: String, sound: UNNotificationSound) {
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.body = body
        content.sound = sound
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func scheduleNotification(expositionInfo: ExpositionInfo) {
        var title, body: String?
        var sound: UNNotificationSound?
        formatter.dateFormat = "dd.MM.YYYY"
        switch expositionInfo.level {
            case .Exposed:
                title = "Riesgo de exposición alto"
                body = "Llama gratis al \(Config.contactNumber) para reportarlo y continuar la simulación del piloto."
//                var desde = ""
//                if let since = expositionInfo.since {
//                    desde = "Desde \(formatter.string(from: since))"
//                }
//                body = "Has estado expuesto. \(desde)"
                sound = .defaultCritical
//            case .Healthy:
//                title = "Exposición Baja"
//                body = "Tu exposicion ahora es baja"
//                sound = .default
            default:
                debugPrint("No notification for exposition: \(expositionInfo.level.rawValue)")
        }
        if let title = title, let body = body, let sound = sound {
            scheduleNotification(title: title, body: body, sound: sound)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Forground notifications.
        completionHandler([.alert, .sound, .badge])
    }
    
}
