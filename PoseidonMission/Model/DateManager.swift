//
//  DateManager.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/17.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation
import Firebase

class DateManager {
    
    static func timeStampToString(date:Timestamp,
                             text: String = "yyyy-MM-dd")
        -> String {
        
    let converted = Date(timeIntervalSince1970:
        TimeInterval(date.seconds) )
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = NSTimeZone.local
    dateFormatter.dateFormat = text
   
        return dateFormatter.string(from: converted)
    }
    
    static func dateToString(date:Date,
                              text: String = "yyyy-MM-dd")
         -> String {
 
     let dateFormatter = DateFormatter()
     dateFormatter.timeZone = NSTimeZone.local
     dateFormatter.dateFormat = text
    
         return dateFormatter.string(from: date)
     }
    
}


