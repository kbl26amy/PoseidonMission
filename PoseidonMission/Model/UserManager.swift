//
//  UserManager.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/8.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation
import Firebase

class UserManager {
    
    var user: UserData?
    var userRecord: [UserRecord] = []
    
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
    
    func getUserRecord(completion: @escaping ([UserRecord]?) -> Void) {
        
        FireBaseHelper.getUserRecord(completion: { querySnapshot in
            
            guard let docs = querySnapshot?.documents else {
                    
                    print("error")
                    
                    completion(nil)
                    
                    return
            }
            
            // 0..< docs.count
            for index in docs.indices {
              
                let score = docs[index].data()["score"] as! Int
                let source = docs[index].data()["source"] as! String
                let time = docs[index].data()["time"] as! Timestamp

                    let converted = Date(timeIntervalSince1970: TimeInterval(time.seconds) )
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeZone = NSTimeZone.local
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let playTime = dateFormatter.string(from: converted as Date)
        
                self.userRecord.append(UserRecord(time: playTime, source: recordSource(rawValue: source) ?? .loginToday, score: score))
            }
            
            completion(self.userRecord)
            
        })
    }
}

