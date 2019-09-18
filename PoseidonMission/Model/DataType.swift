//
//  DataType.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/8.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation
import Firebase

struct UserData {
    
    let email: String
    
    let userName: String
    
    var totalScore: Int?
    
    var mapPlayTime: Timestamp?
    
    var jellyFishPlayTime: Timestamp?
    
    var jellyFishHighest: Int?
    
    var fishingHighest: Int?
   
    var loginCounts: Int?
    
    var loginTodayTime: Timestamp?
    
    var shareTime: Timestamp?
    
    var fishingCounts: Int?
    
    var currentFishingScore: Int?
    
    var fishingTime: Timestamp?
    
    init(email: String, name: String) {
        
        self.email = email
        
        self.userName = name
    }
}

enum recordSource:String {
    
    case map = "map"
    case jellyFish = "jellyFish"
    case fishing = "fish"
    case loginToday = "loginToday"
    case share = "share"
    
}

struct UserRecord {
    
    var time: String
    
    var source:recordSource

    var score: Int
 
}
