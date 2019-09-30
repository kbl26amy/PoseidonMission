//
//  LoginTodayViewController.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/8/27.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import UIKit
import Firebase

class LoginTodayViewController: UIViewController {

    @IBAction func closeLoginToday(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var loginTextMessage: UILabel!
    @IBOutlet weak var leftUpBlueView: UIView!
    @IBOutlet weak var rightDownView: UIView!
    @IBOutlet weak var leftDownView: UIView!
    @IBOutlet weak var rightUpBlueView: UIView!
    @IBOutlet weak var loginTodayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkIsLoginToday()
        
        loginTodayView.layer.cornerRadius = 15
        leftUpBlueView.layer.cornerRadius = 5
        rightUpBlueView.layer.cornerRadius = 5
        rightDownView.layer.cornerRadius = 5
        leftDownView.layer.cornerRadius = 5
    }
    
    func checkIsLoginToday() {
        
        UserManager.shared.getUserData(completion: {user in
            
            if user?.loginTodayTime != nil {
                let loginTodayTime = DateManager.timeStampToString(date:
                    (user?.loginTodayTime)!)
                let currentTime = DateManager.dateToString(date: Date())
                  
                if loginTodayTime == currentTime {
                
                    self.loginTextMessage.text = "明日再來\n您今天已經簽到過了！"
                    self.loginTextMessage.textColor = .red
                    
                } else {
                    self.saveLoginData()
                    self.loginTextMessage.lineBreakMode = NSLineBreakMode.byWordWrapping
                    self.loginTextMessage.numberOfLines = 0
                    self.loginTextMessage.text = " 成功簽到 + 2 暢遊卷 \n 已累積簽到 \(ProfileViewController.loginCounts + 1) 天"
                    
                }
            } else {
                self.saveLoginData()
                self.loginTextMessage.lineBreakMode = NSLineBreakMode.byWordWrapping
                
                self.loginTextMessage.numberOfLines = 0
                self.loginTextMessage.text = " 成功簽到 + 2 暢遊卷 \n 已累積簽到 \(ProfileViewController.loginCounts + 1) 天"
            }
        })
    }
 
    func saveLoginData() {
        
        let loginRecord = ["score":2, "source": "loginToday", "time": FirebaseFirestore.Timestamp(date:Date()) ] as [String : Any]
        FireBaseHelper.saveUserRecord(saveData: loginRecord)
    
        var bonus = 0
        
        switch ProfileViewController.loginCounts {
        case 2:
            bonus = 2
        case 6:
            bonus = 3
        case 13:
            bonus = 5
        case 29:
            bonus = 7
        default:
            bonus = 0
        }

        let updateData = ["totalScore": ProfileViewController.totalScore + 2 + bonus,
                          "loginCounts": ProfileViewController.loginCounts + 1,
                          "loginTodayTime": FirebaseFirestore.Timestamp(date:Date())] as [String : Any]
        
        FireBaseHelper.updateData(update: updateData)
        
    }

}
