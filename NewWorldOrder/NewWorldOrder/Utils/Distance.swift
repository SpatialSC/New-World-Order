//
//  Map.swift
//  mist-ios
//
//  Created by Adam Monterey on 6/17/22.
//

import Foundation

extension Double {
    
    func convertLatDeltaToKms(_ latDelta: Double) -> Double {
        return latDelta * 69 * 1.6
    }

    func metersToFeet() -> Double {
        return self * 3.280839895
    }

    func feetToMiles() -> Double {
        return self / 5280
    }
    
}

func prettyDistance(meters: Double, shortened: Bool) -> String {
    let feet = meters.metersToFeet()
    if feet <= 10 {
        return shortened ? "<10ft" : "<10 feet"
    }
    if feet >= 500 {
        let roundedMiles = Double(Int(feet.feetToMiles() * 10)) / 10
        return String(roundedMiles) + (shortened ? "mi" : " miles")
    } else {
        return String(Int(feet)) + (shortened ? "ft" : " feet")
    }
}
