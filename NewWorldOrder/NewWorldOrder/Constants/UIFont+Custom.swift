//
//  asdf.swift
//  scdatingclub-ios
//
//  Created by Adam Novak on 2022/12/29.
//

//reference: https://stackoverflow.com/questions/8707082/set-a-default-font-for-whole-ios-app
//list of all default iOS fonts: https://stackoverflow.com/questions/20125129/visual-list-of-ios-fonts
//also: https://iosfonts.com

import UIKit

//private let familyName = "Avenir"
private let familyName = "Helvetica"

enum AppFont: String {
    case light = "-Light"
    case medium = ""
    case bold = "-Bold"

    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: fullFontName, size: size + 1.0) {
            return font
        }
        fatalError("Font '\(fullFontName)' does not exist.")
    }
    fileprivate var fullFontName: String {
        return rawValue.isEmpty ? familyName : familyName + rawValue
    }
}

//Helps with finding the exact names of your font after adding them to Xcode.
//The font name is not always the file name.
func printFonts() {
   for familyName in UIFont.familyNames {
       print("\n-- \(familyName) \n")
       for fontName in UIFont.fontNames(forFamilyName: familyName) {
           print(fontName)
       }
   }
}
//
//enum AppFont2: String {
//    case light = "-Light"
//    case regular = "-Regular"
//    case medium = "-Medium"
//    case semibold = "-Semibold"
//    case bold = "-Bold"
//
//    func size(_ size: CGFloat) -> UIFont {
//        if let font = UIFont(name: fullFontName, size: size + 1.0) {
//            return font
//        }
//        fatalError("Font '\(fullFontName)' does not exist.")
//    }
//    fileprivate var fullFontName: String {
//        return rawValue.isEmpty ? familyName2 : familyName2 + rawValue
//    }
//}
