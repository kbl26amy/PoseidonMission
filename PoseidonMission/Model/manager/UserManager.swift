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
    var exchangeRecord: [ExchangeRecord] = []

    static let shared = UserManager()
    
    static var totalScore: Int = 0
    static var jellyFishHighest: Int = 0
    static var fishingHighest: Int = 0
    static var loginCounts: Int = 0
    
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
        
            userData.fishingTime =
                doc.data()?["fishingTime"] as? Timestamp
            
            userData.currentFishingScore =
                doc.data()?["currentFishingScore"] as? Int
            
            userData.fishingCounts =
                doc.data()?["fishingCounts"] as? Int
            
            userData.shareTime =
                doc.data()?["shareTime"] as? Timestamp
            
            userData.loginTodayTime =
                doc.data()?["loginTodayTime"] as? Timestamp
            
            userData.loginCounts =
                doc.data()?["loginCounts"] as? Int
            
            userData.totalScore =
                doc.data()?["totalScore"] as? Int
            
            userData.jellyFishPlayTime =
                doc.data()?["jellyFishPlayTime"] as? Timestamp
            
            userData.jellyFishHighest =
                doc.data()?["jellyFishHighest"] as? Int
            
            userData.mapPlayTime =
                doc.data()?["mapPlayTime"] as? Timestamp
            
            userData.fishingHighest =
                doc.data()?["fishingHighest"] as? Int
            
            userData.photo =
                doc.data()?["photo"] as? String
            
            userData.getGift =
                doc.data()?["getGift"] as? Int
            
            userData.fishGiveId =
                doc.data()?["fishGiveId"] as? [String]
            
            userData.jellyGiveId =
                doc.data()?["jellyGiveId"] as? [String]
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
                let playTime = DateManager.timeStampToString(date: time, text: "yyyy-MM-dd HH:mm:ss")
        
                self.userRecord.append(UserRecord(time: playTime,
                                                  source: RecordSource(rawValue: source) ?? .loginToday,
                                                  score: score))
            }
            
            completion(self.userRecord)
            
        })
    }
    
    func getExchangeRecord(completion: @escaping ([ExchangeRecord]?) -> Void) {
           
           FireBaseHelper.getExchangeRecord(completion: { querySnapshot in
               
               guard let docs = querySnapshot?.documents else {
                       
                       print("error")
                       
                       completion(nil)
                       
                       return
               }
               
               self.exchangeRecord = []
               
               // 0..< docs.count
               for index in docs.indices {
                 
                   let source = docs[index].data()["item"] as! String
                   let introduction = docs[index].data()["introduction"] as! String
                   let time = docs[index].data()["time"] as! Timestamp
                   let playTime = DateManager.timeStampToString(date: time, text: "yyyy-MM-dd HH:mm:ss")
           
                self.exchangeRecord.append(ExchangeRecord(time: playTime, source: source, introduction: introduction))
               }
               
               completion(self.exchangeRecord)
               
           })
       }
}

