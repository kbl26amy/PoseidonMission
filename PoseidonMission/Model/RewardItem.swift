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
    
    var introduction: String {
        switch self {

        case .coupon: return "波賽頓的詔書，似乎有什麼秘密？"

        case .pearl: return "精緻美麗的珍珠，值得收藏！"
        }
    }
    
    var image: UIImage? {
        switch self {

        case .coupon: return UIImage.asset(.paper)

        case .pearl: return UIImage.asset(.pearl)
        }
    }
    
    var title: String {
        switch self {

        case .coupon: return "神秘詔書"

        case .pearl: return "精緻珍珠"
        }
    }
    

}
