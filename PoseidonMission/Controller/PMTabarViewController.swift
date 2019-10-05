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
    
    case exchange
    
    func controller() -> UIViewController {
        
        var controller: UIViewController
        
        switch self {
            
        case .lobby: controller =
            UIStoryboard.lobby.instantiateInitialViewController()!
            
        case .mission: controller = UIStoryboard.mission.instantiateInitialViewController()!
            
        case .profile: controller = UIStoryboard.profile.instantiateInitialViewController()!
            
        case .rank: controller =
            UIStoryboard.rank.instantiateInitialViewController()!
            
        case .exchange: controller =
            UIStoryboard.exchange.instantiateInitialViewController()!
        }
        
        controller.tabBarItem = tabBarItem()
               
        return controller
}
    func tabBarItem() -> UITabBarItem {
        
        switch self {
            
        case .lobby:
            return UITabBarItem(
                title: "首頁",
                image: UIImage.asset(.home),
                selectedImage: UIImage.asset(.home)
            )
            
        case .mission:
            return UITabBarItem(
                title: "任務",
                image: UIImage.asset(.mission),
                selectedImage: UIImage.asset(.mission)
            )
            
        case .rank:
            return UITabBarItem(
                title: "排行",
                image: UIImage.asset(.rank),
                selectedImage: UIImage.asset(.rank)
            )
            
        case .profile:
            return UITabBarItem(
                title: "個人",
                image: UIImage.asset(.profile),
                selectedImage: UIImage.asset(.profile)
            )
            
        case .exchange:
            return UITabBarItem(
                title: "",
                image: UIImage.asset(.treasurebox),
                selectedImage: UIImage.asset(.treasurebox)
            )
        }
}
}
class PMTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    private let tabs: [Tab] = [.lobby, .mission, .exchange, .rank, .profile]
    
     override func viewDidLoad() {
          super.viewDidLoad()
          
          viewControllers = tabs.map({ $0.controller() })
 
          UITabBar.appearance().barTintColor = UIColor.poseidonBlue
          middleTabItemBackground()
          
          delegate = self
     }
     
     func middleTabItemBackground() {
          let bgColor = UIColor.greenBlue
          
          let bgView = UIView(frame:
               CGRect(x: Int(tabBar.frame.width) / 2
                    - Int(tabBar.frame.height) / 2,
                      y: 0,
                      width: Int(tabBar.frame.height),
                      height: Int(tabBar.frame.height)))
          bgView.backgroundColor = bgColor
          bgView.layer.cornerRadius = CGFloat(Int(tabBar.frame.height) / 2)
          tabBar.insertSubview(bgView, at: 0)
     }
    
    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        
        if KeyChainManager.shared.get("userid") == nil{
        
           let loginViewController = UIStoryboard
                                    .auth
                                    .instantiateViewController(withIdentifier: "AuthViewController")
            loginViewController.modalPresentationStyle = .fullScreen
            present(loginViewController, animated: true, completion: nil)
            
            return false
        }
        return true
    }
}
