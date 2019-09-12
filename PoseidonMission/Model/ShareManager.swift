//
//  ShareManager.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/11.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation
import UIKit

class ShareManager {
    
    static func shareClickButton(_ sender: UIViewController) {
        
        let actionSheet = UIAlertController(title: "點擊分享", message: "分享 APP 給你的好友", preferredStyle: UIAlertController.Style.actionSheet)
        
        let facebookPostAction = UIAlertAction(title: "分享", style: UIAlertAction.Style.default) { (action) -> Void in
            
            let shareMessage = URL(string: "https://trello.com/b/O8akxJeO/波賽頓出任務")
            let shareViewController = UIActivityViewController(activityItems: [shareMessage as Any], applicationActivities: nil)
            
            shareViewController.excludedActivityTypes = [UIActivity.ActivityType.mail,UIActivity.ActivityType.airDrop,UIActivity.ActivityType.message]
            
            
           sender.present(shareViewController, animated: true, completion: nil)
            
        }
        
        let dismissAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel) { (action) -> Void in
            
        }
        
        actionSheet.addAction(facebookPostAction)
        actionSheet.addAction(dismissAction)
        
        
        sender.present(actionSheet, animated: true, completion: nil)
    }
}


