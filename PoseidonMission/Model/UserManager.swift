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
    var fishRankData:[RankData] = []
    var jellyRankData:[RankData] = []
    
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
        
            userData.fishingTime = doc.data()?["fishingTime"] as? Timestamp
            userData.currentFishingScore = doc.data()?["currentFishingScore"] as? Int
            userData.fishingCounts = doc.data()?["fishingCounts"] as? Int
            userData.shareTime = doc.data()?["shareTime"] as? Timestamp
            userData.loginTodayTime = doc.data()?["loginTodayTime"] as? Timestamp
            userData.loginCounts = doc.data()?["loginCounts"] as? Int
            userData.totalScore = doc.data()?["totalScore"] as? Int
            userData.jellyFishPlayTime = doc.data()?["jellyFishPlayTime"] as? Timestamp
            userData.jellyFishHighest = doc.data()?["jellyFishHighest"] as? Int
            userData.mapPlayTime = doc.data()?["mapPlayTime"] as? Timestamp
            userData.fishingHighest = doc.data()?["fishingHighest"] as? Int
            
            print(doc.data() as Any)
            print(userData)
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
            
            self.userRecord = []
            
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
        
                self.userRecord.append(UserRecord(time: playTime,
                                                  source: recordSource(rawValue: source) ?? .loginToday, score: score))
            }
            
            completion(self.userRecord)
            
        })
    }
    
    func getJellyHighestData(completion: @escaping ([RankData]?) -> Void) {
        
        FireBaseHelper.getJellyFishHighestData(completion: {querySnapshot in
            
            guard let docs = querySnapshot?.documents else {
                
                print("error")
                
                completion(nil)
                
                return
            }
            
            for index in docs.indices {
                let jellyFishHighest = docs[index].data()["jellyFishHighest"] as? Int
                let name = docs[index].data()["userName"] as? String
                
                self.jellyRankData.append(RankData( name: name!,
                                                highest: jellyFishHighest ?? 0))
            }
        
            completion(self.jellyRankData)
       
        })
        
    }
    func getFishHighestData(completion: @escaping ([RankData]?) -> Void) {
        
        FireBaseHelper.getFishingHighestData(completion: {querySnapshot in
            
            guard let docs = querySnapshot?.documents else {
                
                print("error")
                
                completion(nil)
                
                return
            }
            
            for index in docs.indices {
                
                let fishHighest = docs[index].data()["fishingHighest"] as? Int
                let name = docs[index].data()["userName"] as? String
                
                self.fishRankData.append(RankData( name: name ?? "no name",
                                                highest: fishHighest ?? 0))
            }
            
            completion(self.fishRankData)
            
        })
        
    }

}

