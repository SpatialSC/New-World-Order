//
//  PermissionsManager.swift
//  scdatingclub-ios
//
//  Created by Adam Novak on 2023/01/07.
//

import UIKit

struct PermissionsManager {
    
//    static func areAllPermissionsGranted(closure: @escaping (Bool) -> Void) {
//        Task {
//            let isNotifsEnabled = await NotificationsManager.shared.isNotificationsEnabled()
//            DispatchQueue.main.async { //UIApplication properties must be accessed on main thread
//                let areAllGranted = LocationManager.shared.isLocationServicesProperlyAuthorized() && (UIApplication.shared.backgroundRefreshStatus == .available || ProcessInfo.processInfo.isLowPowerModeEnabled) && isNotifsEnabled
//                closure(areAllGranted)
//            }
//        }
//    }
//    
//    static func areAllNecessaryPermissionsGranted(closure: @escaping (Bool) -> Void) {
//        Task {
//            DispatchQueue.main.async { //UIApplication properties must be accessed on main thread
//                let areAllGranted = LocationManager.shared.isLocationServicesProperlyAuthorized() && (UIApplication.shared.backgroundRefreshStatus == .available || ProcessInfo.processInfo.isLowPowerModeEnabled)
//                closure(areAllGranted)
//            }
//        }
//    }
//    
//    static func ensurePermissionsAreGranted() {
//        areAllPermissionsGranted { granted in
//            if !granted {
//                LocationManager.shared.stopLocationServices()
//                NotificationCenter.default.post(name: .permissionsWereRevoked, object: nil)
//            }
//        }
//    }
//    
//    static func ensureNecessaryPermissionsAreGranted() {
//        areAllNecessaryPermissionsGranted() { granted in
//            if !granted {
//                LocationManager.shared.stopLocationServices()
//                NotificationCenter.default.post(name: .necessaryPermissionsWereRevoked, object: nil)
//            }
//        }
//    }
    
}
