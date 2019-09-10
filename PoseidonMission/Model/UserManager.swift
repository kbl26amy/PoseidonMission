//
//  UserManager.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/8.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation

class UserManager {
    
    var user : UserData?
    
    static let shared = UserManager()
    
    func getUserData(completion: @escaping (UserData?) -> Void) {
        
        FireBaseHelper.getUserData(completion: { snapshot in
            
            guard let doc = snapshot,
                  let email = doc.data()?["email"] as? String,
                  let name = doc.data()?["userName"] as? String
            
            else {
            
                print("error")
                
                completion(nil)
                
                return
            }
            
            //存到變數
            var userData = UserData(email: email, name: name)
            
            userData.totalScore = doc.data()?["totalScore"] as? Int ?? 0
            userData.jellyFishPlayTime = doc.data()?["jellyFishPlayTime"] as? String ?? "never play"
            userData.jellyFishHighest = doc.data()?["jellyFishHighest"] as? Int ?? 0
            userData.mapPlayTime = doc.data()?["mapPlayTime"] as? String ?? "never play"
            userData.fishingHighest = doc.data()?["fishingHighest"] as? Int ?? 0
            userData.fishingPlayTime = doc.data()?["fishingPlayTime"] as? String ?? "never play"
            
            self.user = userData
            
            completion(userData)
            
        })
    }
}

