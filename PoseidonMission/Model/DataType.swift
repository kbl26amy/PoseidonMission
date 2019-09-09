//
//  DataType.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/8.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation

struct UserData {
    
    let email: String
    
    let userName: String
    
    var totalScore: Int = 0
    
    var mapPlayTime: String = ""
    
    var jellyFishPlayTime: String = ""
    
    var jellyFishHighest: Int = 0
    
    var fishingHighest: Int = 0
   
    var fishingPlayTime: String = ""
    
    init(email: String, name: String) {
        
        self.email = email
        
        self.userName = name
    }
}
