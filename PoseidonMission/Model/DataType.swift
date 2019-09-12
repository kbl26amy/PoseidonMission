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
    
    var totalScore: Int = 0
    
    var mapPlayTime: Timestamp = Timestamp()
    
    var jellyFishPlayTime: Timestamp = Timestamp()
    
    var jellyFishHighest: Int = 0
    
    var fishingHighest: Int = 0
    
    var fishingPlayTime: Timestamp = Timestamp()
    
    var loginCounts: Int = 0
    
    var loginTodayTime: Timestamp = Timestamp()
    
    var shareTime: Timestamp = Timestamp()
    
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
    case share = "friend"
    
}

struct UserRecord {
    
    var time: String
    
    var source:recordSource

    var score: Int
 
}
