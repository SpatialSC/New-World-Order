////
////  Version.swift
////  scdatingclub-ios
////
////  Created by Adam Novak on 2022/12/28.
////
//
//import Foundation
//
//enum VersionError: Error {
//    case invalidBundleInfo, invalidResponse
//}
//
//enum Version {
//    static let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
//    
//    static func isVersion(_ versionA: String, newerThan versionB: String) -> Bool? {
//        let componentsA: [Int] = versionA.components(separatedBy: ".").compactMap { Int($0) }
//        let componentsB: [Int] = versionB.components(separatedBy: ".").compactMap { Int($0) }
//        guard componentsB.count == 3, componentsA.count == 3 else { return nil }
//        //we need the == check in the following else ifs in case the apple testers are testing on 3.0.0 but 2.9.9 is available in the app store
//        if componentsA[0] > componentsB[0]{
//            return true
//        } else if componentsA[0] == componentsB[0] &&
//                    componentsA[1] > componentsB[1] {
//            return true
//        } else if componentsA[0] == componentsB[0] &&
//                    componentsA[1] == componentsB[1] &&
//                    componentsA[2] > componentsB[2] {
//            return true
//        } else {
//            return false
//        }
//    }
//    
//    static func checkForNewUpdate() {
//        print("checking for new update")
//        
//        let isUpdateDetailsAvailable =
//        isVersion(Constants.updateAvailableVersion, newerThan: Version.currentVersion) ?? false
//        && isVersion(Constants.updateAvailableVersion, newerThan: DeviceService.shared.getLastReceivedNewUpdateAlertVersion()) ?? false
//        
//        let isUpdateMandatory = isVersion(Constants.updateMandatoryVersion, newerThan: Version.currentVersion) ?? false
//        
//        if isUpdateDetailsAvailable || isUpdateMandatory {
//            let vc = UpdateAvailableVC.create(isMandatory: isUpdateMandatory)
//            vc.modalPresentationStyle = isUpdateMandatory ? .fullScreen : .automatic
//            SceneDelegate.visibleViewController?.present(vc, animated: true)
//        }
//    }
//}
