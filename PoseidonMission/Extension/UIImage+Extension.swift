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
 
    // fishes
    case blueFish
    case redThornFish
    case purpleFish
    case greenFish
    case longFish
    case lightBlueFish
    case darkRedFish
    case LanternFish
    case shark
    
    // jellyFish
    case badJellyfishClick
    case badJellyfish
    case goodJellyfishClick
    case goodJellyfish
    
    //rewards
    case paper
    case pearl
    case seaweed
    case bottle
    
    //missionPic
    case fishingPic
    case jellyFishPic
    case loginPic
    
    //icons
    case fishing
    case jellyFish
    case loginToday
    case map
    case share
    
}

// swiftlint:enable identifier_name

extension UIImage {

    static func asset(_ asset: ImageAsset) -> UIImage? {

        return UIImage(named: asset.rawValue)
    }
}
