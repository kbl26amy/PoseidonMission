//
//  Alert+Extension.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/10/1.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit

extension UIAlertController {

    static func showAlert(message: String,
                          in viewController: UIViewController) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ＯＫ",
                                      style: .cancel))
        
        viewController.present(alert, animated: true)
    }
    
    static func showAlert(message: String) {
        if let viewController = UIApplication
            .shared
            .keyWindow?
            .rootViewController {

            showAlert(message: message, in: viewController)
        }
    }
    
    static func showConfirm(message: String,
                            in viewController: UIViewController,
                            confirm: ((UIAlertAction) -> Void)?) {
        
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "確定", style: .default,
                                      handler: confirm))
        
        viewController.present(alert, animated: true)
    }
    
    static func showConfirm(message: String,
                            confirm: ((UIAlertAction) -> Void)?) {
        
        if let viewController = UIApplication
            .shared
            .keyWindow?
            .rootViewController {
            
            showConfirm(message: message,
                        in: viewController,
                        confirm: confirm)
        }
    }
    
    typealias Handler = (UIAlertAction) -> ()
    func buildAlert(viewController: UIViewController,handler : @escaping Handler){
        let alertController = UIAlertController(title: "Alert", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(alertAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
