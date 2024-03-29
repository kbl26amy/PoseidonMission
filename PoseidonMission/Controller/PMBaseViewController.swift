//
//  PMBaseViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation
import UIKit

class PMBaseViewController: UIViewController {
    
    static var identifier: String {
        
        return String(describing: self)
    }
    
    var isHideNavigationBar: Bool {
        
        return false
    }
    
    var isEnableResignOnTouchOutside: Bool {
        
        return false
    }
    
    var isEnableIQKeyboard: Bool {
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isHideNavigationBar {
            navigationItem.hidesBackButton = true
        }
        
        self.view.backgroundColor = UIColor(
            patternImage: UIImage.asset(.missionbackground)!)
           
        navigationController?.navigationBar.barTintColor = UIColor.poseidonBlue
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil,
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
        
        navigationController?
            .navigationBar
            .backIndicatorImage = UIImage.asset(.back02)
        
        navigationController?
            .navigationBar
            .backIndicatorTransitionMaskImage = UIImage.asset(.back02)
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if isHideNavigationBar {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }

        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isHideNavigationBar {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
    }
    
    @IBAction func popBack(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc @IBAction func backToRoot(_ sender: Any) {
        
        backToRoot(completion: nil)
    }
    
    
}

extension UIViewController {
    
    func backToRoot(completion: (() -> Void)? = nil) {
        
        if presentingViewController != nil {
            
            let superVC = presentingViewController
            
            dismiss(animated: false, completion: nil)
            
            superVC?.backToRoot(completion: completion)
            
            return
        }
        
        if self is UITabBarController {
            
            let vc = (self as? UITabBarController)?.selectedViewController
            
            vc?.backToRoot(completion: completion)
            
            return
        }
        
        if self is UINavigationController {
            
            (self as! UINavigationController).popToRootViewController(animated: false)
        }
        
        if  ((self.navigationController?.viewControllers.first) != nil){
            
            self.navigationController!.popToRootViewController(animated: false)
        }

        
        completion?()
    }
}

