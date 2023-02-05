//
//  Constants.swift
//  timewellspent-ios
//
//  Created by Adam Novak on 2022/11/19.
//

import Foundation

enum Constants {
    
    static let maxPasswordLength = 1000
    
    struct Filesystem {
        static let AccountPath: String = "myaccount.json"
    }
    
    struct UserDefaultsKeys {
        static let isOnWaitList: String = "isOnWaitList"
    }

    static let appDisplayName = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    static let appTechnicalName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String

    static let defaultMailLink = URL(string: "mailto://")!
    static let gmailLink = URL(string: "googlegmail://")!
    static let appStoreLink = URL(string: "https://apps.apple.com/app/apple-store/id1668940768")!
    static let companyLink = URL(string: "https://newworldorder.com")!
    static let contactEmailLink = URL(string: "mailto:leaveylabs@gmail.com")!

    // Note: all nib names should be the same ss their storyboard ID
    struct SBID {
        struct View {
            
        }
        struct SB {
            static let Main = "Main"
            static let Launch = "Launch"
        }
        struct Cell {
            static let MenuItemTableCell = "MenuItemTableCell"
            static let SettingsCell = "SettingsCell"
        }
        struct VC {
            //Home
            static let MenuVC = "MenuVC"
            static let CheckoutVC = "CheckoutVC"
            static let MoreVC = "MoreVC"
            static let ItemSheetVC = "ItemSheetVC"
        }
        struct Segue {
            
        }
    }
    
}
