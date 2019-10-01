//
//  DataType.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/8.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation
import Firebase
import AuthenticationServices

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
    
    var photo: String?
    
    init(email: String, name: String) {
        
        self.email = email
        
        self.userName = name
    }
}

enum RecordSource:String {
    
    case map = "map"
    case jellyFish = "jellyFish"
    case fishing = "fishing"
    case loginToday = "loginToday"
    case share = "share"
    
}

struct UserRecord {
    
    var time: String
    
    var source:RecordSource

    var score: Int
 
}

struct RankData {
    
    var userId: String
    var name: String
    var highest: Int
    var photo: String?
   
}

struct AppleUser {
    let id: String
        let firstName: String
        let lastName: String
        let email: String
        
        init(credentials: ASAuthorizationAppleIDCredential) {
            self.id = credentials.user
            self.firstName = credentials.fullName?.givenName ?? ""
            self.lastName = credentials.fullName?.familyName ?? ""
            self.email = credentials.email ?? ""
        }

    }

    extension AppleUser: CustomDebugStringConvertible {
        var debugDescription: String {
            return """
            ID: \(id)
            First Name: \(firstName)
            Last Name: \(lastName)
            Email: \(email)
            """
        }
    }
