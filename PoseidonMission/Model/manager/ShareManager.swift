//
//  ShareManager.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/11.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ShareManager {
    
    static func shareClickButton(_ sender: UIViewController) {
        
        let actionSheet = UIAlertController(title: "點擊分享",
                                            message: "分享 APP 給你的好友",
                                            preferredStyle:
            UIAlertController
                .Style
                .actionSheet)
        
        let facebookPostAction = UIAlertAction(title: "分享",
                                               style: UIAlertAction.Style.default)
        { (action) -> Void in
            
            guard let url = URL(string: "https://itunes.apple.com/tw/app/id1481162004"),
                let image = UIImage.asset(.fbbanner)
                else { return }
            
            let text = "和我一起玩波賽頓出任務，前往海底尋找神秘寶藏吧！"
            let shareMessage: [Any] = [text, image, url]
            let shareViewController = UIActivityViewController(
                activityItems: shareMessage,
                applicationActivities: nil)
            
            
            shareViewController
                .excludedActivityTypes = [UIActivity.ActivityType.mail,
                                          UIActivity.ActivityType.airDrop,
                                          UIActivity.ActivityType.message,
                                          UIActivity.ActivityType.addToReadingList,
                                          UIActivity.ActivityType.copyToPasteboard,
                                          UIActivity.ActivityType.assignToContact,
                                          UIActivity.ActivityType.print,
                                          UIActivity.ActivityType.openInIBooks,
                                          
            ]
            saveShareData()
            
            sender.present(shareViewController,
                           animated: true,
                           completion: nil)
            
        }
        
        let dismissAction = UIAlertAction(title: "Close",
                                          style: UIAlertAction.Style.cancel)
        { (action) -> Void in
        }
        
        actionSheet.addAction(facebookPostAction)
        actionSheet.addAction(dismissAction)
        
        sender.present(actionSheet, animated: true, completion: nil)
    }
    
    static func saveShareData() {
        
        let loginRecord = ["score":2,
                           "source": "share",
                           "time": FirebaseFirestore.Timestamp(date:Date()) ]
            as [String : Any]
        FireBaseHelper.saveUserRecord(saveData: loginRecord)
        
        let updateData = ["totalScore": UserManager.totalScore + 2 ,
                          "shareTime": FirebaseFirestore.Timestamp(date:Date())]
            as [String : Any]
        
        FireBaseHelper.updateData(update: updateData)
        
    }
    
    static func checkIsShareToday(sender: UIViewController) {
        
        UserManager.shared.getUserData(completion: {user in
            
            if user?.shareTime != nil {
                
                let shareTodayTime = DateManager.timeStampToString(date: (user?.shareTime)!)
                let currentTime = DateManager.dateToString(date: Date())
                
                if shareTodayTime == currentTime {
                    
                    UIAlertController.showAlert(message: "今日已經分享過了！")
                    
                } else {
                    shareClickButton(sender)
                }
            } else {
                shareClickButton(sender)
            }
        })
    }
}




