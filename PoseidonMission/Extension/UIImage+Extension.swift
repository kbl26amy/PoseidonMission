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
    
    case fbbanner
    case ship
    case champion
    
    //tabbar icon
    case home
    case mission
    case rank
    case profile
    case treasurebox
    
    //mission page
    case missionbackground
    case back02
    case missiontask
    
    //map page
    case mapbackground
    case showmap
    case unmap
    case nomap
    case getreward
    case unreward
    
    //jellyfish page
    case jellyfishbackground
    case hole
    
    case background
    case fishingRod
    case fishingLine
    case rightButton
    case leftButton
    case fishingHook
    
    case treasure
    case register
    case account
    case password
    case login
    
    case coin
    case treasureBox
}

// swiftlint:enable identifier_name

extension UIImage {

    static func asset(_ asset: ImageAsset) -> UIImage? {

        return UIImage(named: asset.rawValue)
    }
}
