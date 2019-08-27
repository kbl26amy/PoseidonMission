//
//  UIStoryboard+Extension.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/26.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

private struct StoryboardCategory {
    
    static let main = "Main"
    
    static let lobby = "Lobby"
    
    static let mission = "Mission"
    
    static let profile = "Profile"
    
     static let rank = "Rank"

}

extension UIStoryboard {
    
    static var main: UIStoryboard { return pmStoryboard(name: StoryboardCategory.main) }
    
    static var lobby: UIStoryboard { return pmStoryboard(name: StoryboardCategory.lobby) }
    
    static var mission: UIStoryboard { return pmStoryboard(name: StoryboardCategory.mission) }
    
    static var profile: UIStoryboard { return pmStoryboard(name: StoryboardCategory.profile) }
    static var rank: UIStoryboard { return pmStoryboard(name: StoryboardCategory.rank) }
 
    private static func pmStoryboard(name: String) -> UIStoryboard {
        
        return UIStoryboard(name: name, bundle: nil)
    }
}
