//
//  NotificationsManager.swift
//  mist-ios
//
//  Created by Adam Monterey on 8/29/22.
//

import UserNotifications
import UIKit

//MARK: - Structs

//Internal Notifications
extension Notification.Name {
    static let locationDidUpdate = Notification.Name("locationDidUpdate")
    static let locationStatusDidUpdate = Notification.Name("locationStatusDidUpdate")
    static let remoteConfigDidActivate = Notification.Name("remoteConfigDidActivate")
    static let permissionsWereRevoked = Notification.Name("permissionsWereRevoked")
    static let necessaryPermissionsWereRevoked = Notification.Name("necessaryPermissionsWereRevoked")
    static let matchAccepted = Notification.Name("matchAccepted")
    static let matchReceived = Notification.Name("matchReceived")
}

//Remote Notifications
enum NotificationType: String, CaseIterable {
    case match = "match"
    case accept = "accept"
    case stop = "stop"
}

extension Notification {
    enum extra: String {
        case type = "type"
        case data = "data"
    }
}

struct NotificationResponseHandler {
    var notificationType: NotificationType
    var notificationDate: Date!
}

//MARK: - NotificationsManager

class NotificationsManager: NSObject {
    
    private var center: UNUserNotificationCenter = UNUserNotificationCenter.current()
    static let shared = NotificationsManager()
    var currentlyLaunchedAppNotification: UNNotification?
    
    private override init() {
        super.init()
    }
    
    //MARK: - Permission and Status
    
    func getNotificationStatus() async -> UNAuthorizationStatus {
        return await center.notificationSettings().authorizationStatus
    }
    
    func isNotificationsEnabled() async -> Bool {
        return await center.notificationSettings().authorizationStatus == .authorized
    }
    
    func registerForNotificationsOnStartupIfAccessExists() {
        center.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    print("REGISTERED FOR NOTIFICATIONS")
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        })
    }
    
    func askForNewNotificationPermissionsIfNecessary(closure: @escaping (_ granted: Bool) -> Void = { _ in } ) {
        center.getNotificationSettings(completionHandler: { [self] (settings) in
            switch settings.authorizationStatus {
            case .denied:
                closure(false)
            case .notDetermined:
                self.center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                    if granted {
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    }
                    closure(granted)
                }
            default:
                closure(true)
            }
        })
    }
    
    //we just need to make sure to also check the currently launched notification, and make sure we don't handle anything newer than that

    func checkPreviouslyReceivedMatchNotification() {
        Task {
            guard await isNotificationsEnabled() else { return }
            
            //The below function returns all the notifications currently visible in the NotificationCenter on their device
            //As soon as the user clicks on a notification to open the app, that notification is gone from the notification center (and thus won't be returned from the below function). That action should be handled in AppDelegate
//            let deliveredNotifications = await center.deliveredNotifications().sorted(by: { $0.date.isMoreRecentThan($1.date)} )
//            if deliveredNotifications.count > 0 {
//                print("opened app with delivered notifications:", deliveredNotifications)
//            }
//
//            //THREE CHECKS: received, saved, opened notifications
//            //1 saved notification (saved into the app through a previous phone unlock)
//            //2 received notification (sitting in notification center)
//            //3 opened notification (notification you clicked on)
//            //you can't guarantee anyo one of these is newest. we want to put the app in the state of the newest notification
//
//            var mostRecentHandler: NotificationResponseHandler?
//
//            //Saved notification
//            if let mostRecentSavedUserInfo = mostRecentSavedNotificationUserInfo(),
//               let savedHandler = generateNotificationResponseHandler(userInfo: mostRecentSavedUserInfo)
//            {
//                mostRecentHandler = savedHandler
//            }
//
//            //Received notification
//            if let recentReceivedNotif = deliveredNotifications.first,
//               let recentReceivedHandler = generateNotificationResponseHandler(recentReceivedNotif) {
//                if mostRecentHandler == nil {
//                    mostRecentHandler = recentReceivedHandler
//                } else {
//                    if recentReceivedHandler.notificationDate.isMoreRecentThan(mostRecentHandler!.notificationDate) {
//                        mostRecentHandler = recentReceivedHandler
//                    }
//                }
//            }
//
//            //Opened notification
//            if let currentlyLaunchedAppNotification,
//               let openedHandler = generateNotificationResponseHandler(currentlyLaunchedAppNotification) {
//                if mostRecentHandler == nil {
//                    mostRecentHandler = openedHandler
//                } else {
//                    if openedHandler.notificationDate.isMoreRecentThan(mostRecentHandler!.notificationDate) {
//                        mostRecentHandler = openedHandler
//                    }
//                }
//            }
//
//            var activeHandler: NotificationResponseHandler?
//            let threeMinsAgo = Calendar.current.date(byAdding: .minute, value: max(Constants.minutesToConnect, Constants.minutesToRespond) * -1, to: Date())!
//            if let mostRecentHandler,
//                  mostRecentHandler.notificationDate.isMoreRecentThan(threeMinsAgo) {
//                activeHandler = mostRecentHandler
//            }
//            guard let activeHandler else { return }
//
//            DispatchQueue.main.async {
//                let loadingVC = LoadingVC.create(notificationResponseHandler: activeHandler)
//                transitionToViewController(loadingVC, duration: 0)
//                UIApplication.shared.applicationIconBadgeNumber = 0
//            }
//            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        }
    }
    
    func generateNotificationResponseHandler(_ notification: UNNotification) -> NotificationResponseHandler? {
        guard let userInfo = notification.request.content.userInfo as? [String : AnyObject] else {
            return nil
        }
        return generateNotificationResponseHandler(userInfo: userInfo)
    }
    
    func generateNotificationResponseHandler(userInfo: [String:AnyObject]) -> NotificationResponseHandler? {
        
//        guard
//            let notificationTypeString = userInfo[Notification.extra.type.rawValue] as? String,
//            let notificationType = NotificationType.init(rawValue: notificationTypeString)
//        else { return nil }
//
//        saveNotificationUserInfo(userInfo: userInfo)
//
//        do {
//            guard let json = userInfo[Notification.extra.data.rawValue] else { return nil }
//            let data = try JSONSerialization.data(withJSONObject: json as Any, options: .prettyPrinted)
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//            var handler = NotificationResponseHandler(notificationType: notificationType)
//            switch notificationType {
//                case .match:
//                    handler.newMatchPartner = try decoder.decode(MatchPartner.self, from: data)
//                    handler.notificationDate = Date(timeIntervalSince1970: handler.newMatchPartner!.time)
//                case .accept:
//                    handler.newMatchAcceptance = try decoder.decode(MatchAcceptance.self, from: data)
//                    handler.notificationDate = Date(timeIntervalSince1970: handler.newMatchAcceptance!.time)
//                case .stop:
//                    break
//            }
//            return handler
//        } catch {
//            let analyticsId = "notiifcation"
//            let analyticsTitle = "displayingVCafterRemoteNotificationFailed"
//            Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
//              AnalyticsParameterItemID: "id-\(analyticsId)",
//              AnalyticsParameterItemName: analyticsTitle,
//            ])
//            return nil
//        }
        return nil
    }
    
    //MARK: - Local Storage
        
//    func mostRecentSavedNotificationUserInfo() -> [String: AnyObject]? {
//        return UserDefaults.standard.object(forKey: Constants.UserDefaultsKeys.MostRecentNotifiationStorageKey) as? [String: AnyObject] ?? nil
//    }
//
//    func saveNotificationUserInfo(userInfo: [String: AnyObject]) {
//        Task {
//            UserDefaults.standard.set(userInfo.withoutNullEntries(), forKey: Constants.UserDefaultsKeys.MostRecentNotifiationStorageKey)
//        }
//    }
        
//    func mostRecentSavedMatchInfo() -> MatchInfo? {
//        let data = UserDefaults.standard.object(forKey: MostRecentNotifiationStorageKey) as! Data
//        let notification = try JSONDecoder().decode(Notification.self, from: data)
//        return notification
//    }
//
//    func saveMatchInfo(_ matchInfo: MatchInfo) {
//        Task {
//            let encoded = try JSONEncoder().encode(notification)! {
//                UserDefaults.standard.set(encoded, forKey: MostRecentNotifiationStorageKey)
//            }
//        }
//    }
}
