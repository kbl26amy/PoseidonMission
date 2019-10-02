//
//  UIImage+Extension.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/30.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation
import UIKit

enum ImageAsset: String {
 
    // swiftlint:disable identifier_name
    case blueFish
    case redThornFish
    case purpleFish
    case greenFish
    case longFish
    case lightBlueFish
    case darkRedFish
    case LanternFish
    case shark
    
    
    case badJellyfishClick
    case badJellyfish
    case goodJellyfishClick
    case goodJellyfish
    
    case paper
    case pearl
    
}

// swiftlint:enable identifier_name

extension UIImage {

    static func asset(_ asset: ImageAsset) -> UIImage? {

        return UIImage(named: asset.rawValue)
    }
}
