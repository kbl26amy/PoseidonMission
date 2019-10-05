//
//  championRank.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/10/4.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation
import UIKit

protocol ChampionRank {
    
    var title: String { get }
    var image: UIImage? { get }
}

struct Champion {
    let item : [ChampionRank]
}

enum ChampionList: ChampionRank {
  
    case fishing

    case jellyFish
    
    case login
    
    var title: String {
        
         switch self {
         case .fishing: return "釣魚總冠軍"
            
         case .jellyFish: return "打水母冠軍"
            
         case .login: return "簽到總冠軍"
            
        }
    }
    var image: UIImage? {
        
        switch self {

        case .fishing: return UIImage.asset(.fishingPic)!

        case .jellyFish: return UIImage.asset(.jellyFishPic)!
       
        case .login: return UIImage.asset(.loginPic)!
            
        }
    }
    
}
