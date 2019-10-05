//
//  UIColor+Extension.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/10/5.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation
import UIKit

private enum PMColor: String  {

    case poseidonBlue

    case greenBlue

    case darkBlue

    case lightGreen

    case lightBlue

    case lightPurple
    
    case lightRed
    
    case lightOrange

}

extension UIColor {

    static let poseidonBlue = PMColor(.poseidonBlue)

    static let greenBlue = PMColor(.greenBlue)

    static let darkBlue = PMColor(.darkBlue)

    static let lightGreen = PMColor(.lightGreen)

    static let lightBlue = PMColor(.lightBlue)

    static let lightPurple = PMColor(.lightPurple)

    static let lightRed = PMColor(.lightRed)

    static let lightOrange = PMColor(.lightOrange)

    private static func PMColor(_ color: PMColor) -> UIColor? {
       return UIColor(named: color.rawValue)
    }
    static func hexStringToUIColor(hex: String) -> UIColor {

        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
