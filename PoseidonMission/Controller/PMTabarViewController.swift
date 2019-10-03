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
            
        case .exchange:
            return UITabBarItem(
                title: "",
                image: UIImage(named: "treasurebox"),
                selectedImage: UIImage(named: "treasurebox")
            )
        }
}
}
class PMTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    private let tabs: [Tab] = [.lobby, .mission, .exchange, .rank, .profile]
    
     override func viewDidLoad() {
          super.viewDidLoad()
          
          viewControllers = tabs.map({ $0.controller() })
 
          UITabBar.appearance().barTintColor =
               UIColor(red: 131.0/255.0,
                       green: 211.0/255.0,
                       blue: 222.0/255.0,
                       alpha: 1.0)
          middleTabItemBackground()
          
          delegate = self
     }
     
     func middleTabItemBackground() {
          let bgColor = UIColor(red: 0.08, green: 0.726, blue: 0.702, alpha: 1.0)
          
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
