//
//  HotItem.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/10/4.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation
import UIKit

protocol HotItem {
    
    var title: String { get }
    var image: UIImage? { get }
    var color: UIColor { get }
}

struct HotItemList {
    let item : [HotItem]
}

enum Hots: HotItem {
  
    case map

    case fishing
    
    case jellyFish
    
    case loginToday
    
    case invite
    
    var title: String {
        
        switch self {
        case .map: return "藏寶圖"
        case .fishing: return "釣魚"
        case .jellyFish: return "打水母"
        case .loginToday: return "簽到"
        case .invite: return "邀請好友"
            
        }
    }
    var image: UIImage? {
        
        switch self {
        case .map: return UIImage.asset(.map)
        case .fishing: return UIImage.asset(.fishing)
        case .jellyFish: return UIImage.asset(.jellyFish)
        case .loginToday: return UIImage.asset(.loginToday)
        case .invite: return UIImage.asset(.share)
            
        }
    }
    
    var color: UIColor {
        
        switch self {
            
        case .map: return
            UIColor(red: 127/255, green: 197/255, blue: 0, alpha: 1)
        case .fishing: return
            UIColor(red: 139/255, green: 152/255, blue: 206/255, alpha: 1)
        case .jellyFish: return
            UIColor(red: 139/255, green: 152/255, blue: 206/255, alpha: 1)
        case .loginToday: return
            UIColor(red: 249/255, green: 97/255, blue: 43/255, alpha: 1)
        case .invite: return
            UIColor(red: 255/255, green: 181/255, blue: 37/255, alpha: 1)
            
        }
    }
    
    

}
