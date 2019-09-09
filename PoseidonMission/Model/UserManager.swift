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
                  let name = doc.data()?["userName"] as? String,
                  let score = doc.data()?["totalScore"] as? Int,
                  let jellyFishPlayTime = doc.data()?["jellyFishPlayTime"] as? String,
                  let mapPlayTime = doc.data()?["mapPlayTime"] as? String,
                  let jellyFishHighest = doc.data()?["jellyFishHighest"] as? Int,
                  let fishingHighest = doc.data()?["fishingHighest"] as? Int,
                  let fishingPlayTime = doc.data()?["fishingPlayTime"] as? String
                
            else {
            
                print("error")
                
                completion(nil)
                
                return
            }
            
            //存到變數
            var userData = UserData(email: email, name: name)
            
            userData.totalScore = score
            userData.jellyFishPlayTime = jellyFishPlayTime
            userData.jellyFishHighest = jellyFishHighest
            userData.mapPlayTime = mapPlayTime
            userData.fishingHighest = fishingHighest
            userData.fishingPlayTime = fishingPlayTime
            
            self.user = userData
            
            completion(userData)
            
        })
    }
}

