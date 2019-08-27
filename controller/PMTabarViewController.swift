//
//  PMTabarViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/26.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

private enum Tab {
    
    case lobby
    
    case mission
    
    case rank
    
    case profile
    
    func controller() -> UIViewController {
        
        var controller: UIViewController
        
        switch self {
            
        case .lobby: controller = UIStoryboard.lobby.instantiateInitialViewController()!
            
        case .mission: controller = UIStoryboard.mission.instantiateInitialViewController()!
            
        case .profile: controller = UIStoryboard.profile.instantiateInitialViewController()!
            
        case .rank: controller = UIStoryboard.rank.instantiateInitialViewController()!
            
        }
        
        controller.tabBarItem = tabBarItem()
        
        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 6.0, left: 0.0, bottom: -6.0, right: 0.0)
        
        return controller
}
    func tabBarItem() -> UITabBarItem {
        
        switch self {
            
        case .lobby:
            return UITabBarItem(
                title: nil,
                image: UIImage(named: "homeNotHit"),
                selectedImage: UIImage(named: "home")
            )
            
        case .mission:
            return UITabBarItem(
                title: nil,
                image: UIImage(named: "mission"),
                selectedImage: UIImage(named: "missionhit")
            )
            
        case .rank:
            return UITabBarItem(
                title: nil,
                image: UIImage(named: "rank"),
                selectedImage: UIImage(named: "rankhit")
            )
            
        case .profile:
            return UITabBarItem(
                title: nil,
                image: UIImage(named: "profile"),
                selectedImage: UIImage(named: "profilehit")
            )
        }
}
}
