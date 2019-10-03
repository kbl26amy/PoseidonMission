//
//  RewardItem.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/10/2.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation
import UIKit

protocol RewardItem {

    var image: UIImage? { get }

    var title: String { get }
    
    var introduction: String { get }
}

struct RewardGroup {
    let item : [RewardItem]
}

enum Rewards: RewardItem {
    
    case coupon

    case pearl
    
    case seaweed
    
    case bottle
    
    var introduction: String {
        switch self {

        case .coupon: return "波賽頓的詔書，似乎有什麼秘密？"

        case .pearl: return "精緻美麗的珍珠，值得收藏！"
            
        case .seaweed: return "隨處可見的海草，毫無用處。"
            
        case .bottle: return "裝著信紙的漂流瓶，找不到寄件人。"
        }
    }
    
    var image: UIImage? {
        switch self {

        case .coupon: return UIImage.asset(.paper)

        case .pearl: return UIImage.asset(.pearl)
       
        case .seaweed: return UIImage.asset(.seaweed)
            
            case .bottle: return UIImage.asset(.bottle)
        }
    }
    
    var title: String {
        switch self {

        case .coupon: return "神秘詔書"

        case .pearl: return "精緻珍珠"
            
        case .seaweed: return "海草"
            
        case .bottle: return "漂流瓶"
            
        }
    }
    

}
