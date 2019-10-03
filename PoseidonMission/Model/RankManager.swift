//
//  UserInfo.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/25.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation

class RankManager {
    
    static let shared = RankManager()
    
    var fishRankData:[RankData] = []
    var jellyRankData:[RankData] = []
    var loginRankData:[RankData] = []
   
    func getJellyHighestData(completion: @escaping ([RankData]?) -> Void) {
           
           FireBaseHelper.getJellyFishHighestData(completion: {querySnapshot in
               
               guard let docs = querySnapshot?.documents else {
                   
                   print("error")
                   
                   completion(nil)
                   
                   return
               }
               self.jellyRankData = []
               
               for index in docs.indices {
                   let jellyFishHighest =
                       docs[index].data()["jellyFishHighest"] as? Int
                   
                   let userId =
                       docs[index].documentID as String
                   
                   let name =
                       docs[index].data()["userName"] as? String
                   
                   let photo =
                       docs[index].data()["photo"] as? String
                   
                   
                   self.jellyRankData.append(RankData( userId: userId, name: name!,
                                                       highest: jellyFishHighest ?? 0,
                                                       photo: photo))
               }
           
               completion(self.jellyRankData)
          
           })
           
       }
       func getFishHighestData(completion: @escaping ([RankData]?) -> Void) {
           
           FireBaseHelper.getFishingHighestData(completion:
               {querySnapshot in
               
               guard let docs = querySnapshot?.documents else {
                   
                   print("error")
                   
                   completion(nil)
                   
                   return
               }
               self.fishRankData = []
               for index in docs.indices {
                   
                   let fishHighest =
                       docs[index].data()["fishingHighest"] as? Int
                   
                   let userId =
                   docs[index].documentID as String
                   
                   let name =
                       docs[index].data()["userName"] as? String
                   
                   let photo =
                       docs[index].data()["photo"] as? String
                   
                   self.fishRankData.append(RankData(userId: userId,
                                                     name: name ?? "no name",
                                                   highest: fishHighest ?? 0,
                                                   photo: photo))
               }
               
               completion(self.fishRankData)
               
           })
           
       }
       func getLoginHighestData(completion:
           @escaping ([RankData]?) -> Void) {
           
           FireBaseHelper.getLoginHighestData(completion:
               {querySnapshot in
               
               guard let docs = querySnapshot?.documents else {
                   
                   print("error")
                   
                   completion(nil)
                   
                   return
               }
               self.loginRankData = []
               for index in docs.indices {
                   
                   let userId =
                   docs[index].documentID as String
                   
                   let loginHighest =
                       docs[index].data()["loginCounts"] as? Int
                   
                   let name =
                       docs[index].data()["userName"] as? String
                   
                   self.loginRankData.append(RankData( userId: userId,
                                                       name: name ?? "no name",
                                                      highest: loginHighest ?? 0))
               }
               
               completion(self.loginRankData)
               
           })
           
       }
}
