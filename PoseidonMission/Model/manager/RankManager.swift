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

    var rankData:[RankData] = []
   
    func getHighestData(type: ChampionList, completion:
           @escaping ([RankData]) -> Void) {
           
        FireBaseHelper.getHighestData(queryParameter: type.queryParameter, completion:
               {querySnapshot in
               
               guard let docs = querySnapshot?.documents else {
                   
                   print("error")
                   
                completion(self.rankData)
                   
                   return
               }
                
               self.rankData = []
                
                for index in docs.indices {
                    
                    let userId =
                        docs[index].documentID as String
                    
                    let highest =
                        docs[index].data()[type.queryParameter] as? Int
                    
                    let photo =
                        docs[index].data()["photo"] as? String
                    
                    let name =
                        docs[index].data()["userName"] as? String
                    
                    self.rankData.append(
                        RankData( userId: userId,
                                  name: name ?? "no name",
                                  highest: highest ?? 0,
                                  photo: photo))
                }
            
                completion(self.rankData) 
        })
        
    }
}
