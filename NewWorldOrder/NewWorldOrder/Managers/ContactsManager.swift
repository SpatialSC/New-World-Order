//
//  ContactsManager.swift
//  cleanmessage-ios
//
//  Created by Adam Novak on 2023/01/30.
//

import Contacts
import UIKit

class ContactsManager {
        
    //MARK: - Permission
    
    static var allContacts: [CNContact] = []
    
    static func requestContactsIfNecessary(onController controller: UIViewController, closure: @escaping (_ approved: Bool) -> Void) {
        let contactStore = CNContactStore()
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .notDetermined:
            contactStore.requestAccess(for: .contacts) { approved, _ in
                if approved {
                    closure(true)
                } else {
                    closure(false)
                }
            }
        case .authorized:
            closure(true)
        default:
            DispatchQueue.main.async {
                AlertManager.showSettingsAlertController(title: "share your contacts in settings", message: "", settingsType: .contacts, cancelActionHandler: {
                    
                }, on: controller)
            }
        }
    }
    
    //MARK: - FetchContacts
    
    static func fetchFilteredContacts(partialString: String) async -> [CNContact] {
        let contactStore = CNContactStore()
        do {
            let predicate: NSPredicate = CNContact.predicateForContacts(matchingName: partialString)
            let keysToFetch = [CNContactGivenNameKey,
                               CNContactFamilyNameKey,
                               CNContactPhoneNumbersKey,
                               CNContactThumbnailImageDataKey,
                               CNContactImageDataAvailableKey] as [CNKeyDescriptor]
            let contacts = try contactStore.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
            return contacts
        } catch {
            print("Failed to fetch contact, error: \(error)")
            return []
        }
    }
    
    static func fetchAllContacts() async {
        let contactStore = CNContactStore()
        var contacts = [CNContact]()
        let keysToFetch = [CNContactGivenNameKey,
                           CNContactFamilyNameKey,
                           CNContactPhoneNumbersKey,
                           CNContactThumbnailImageDataKey,
                           CNContactImageDataAvailableKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keysToFetch)
        
        do {
          try contactStore.enumerateContacts(with: request) {
              (contact, stop) in
              // Array containing all unified contacts from everywhere
              contacts.append(contact)
          }
        }
        catch {
          print("unable to fetch contacts")
        }
        allContacts = contacts
    }
    
}
