//
//  Dict+RemoveNullEntries.swift
//  scdatingclub-ios
//
//  Created by Adam Novak on 2023/01/24.
//

import Foundation

extension Dictionary {
    
    func withoutNullEntries() -> Dictionary {
        var noNullDict = self
        for (key, elem) in noNullDict {
            if elem is NSNull { // NSNull is a singleton, so this check is sufficient
                noNullDict.removeValue(forKey: key)
            }
        }
        return noNullDict
    }
}
