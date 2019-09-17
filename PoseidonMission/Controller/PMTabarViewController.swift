//
//  PMTabarViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/26.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit
import Firebase

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
        
// 客製化 tabBarItem 
//        controller.tabBarItem.imageInsets = UIEdgeInsets(top: -6, left: 0.0, bottom: -6, right: 0.0)
//        controller.tabBarItem.titlePositionAdjustment.vertical = 5
        
        return controller
}
    func tabBarItem() -> UITabBarItem {
        
        switch self {
            
        case .lobby:
            return UITabBarItem(
                title: "首頁",
                image: UIImage(named: "home"),
                selectedImage: UIImage(named: "home")
            )
            
        case .mission:
            return UITabBarItem(
                title: "任務",
                image: UIImage(named: "mission"),
                selectedImage: UIImage(named: "mission")
            )
            
        case .rank:
            return UITabBarItem(
                title: "排行",
                image: UIImage(named: "rank"),
                selectedImage: UIImage(named: "rank")
            )
            
        case .profile:
            return UITabBarItem(
                title: "個人",
                image: UIImage(named: "profile"),
                selectedImage: UIImage(named: "profile")
            )
        }
}
}
class PMTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
     private let tabs: [Tab] = [.lobby, .mission, .rank, .profile]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = tabs.map({ $0.controller() })
 
//        UITabBar.appearance().barTintColor = UIColor(red: 131.0/255.0, green: 211.0/255.0, blue: 222.0/255.0, alpha: 1.0)

        delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
 
        if Auth.auth().currentUser == nil{
        
           let loginViewController = UIStoryboard.auth.instantiateViewController(withIdentifier: "AuthViewController")
            
            present(loginViewController, animated: true, completion: nil)
            
            return false
        }
        return true
    }
}
