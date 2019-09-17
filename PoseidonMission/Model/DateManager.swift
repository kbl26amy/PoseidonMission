//
//  DateManager.swift
//  PoseidonMission
//
//  Created by 楊雅涵 on 2019/9/17.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import Foundation

class DateManager {
    
    func dateToString(date:Date, text: String = "yyyy") -> String {
        
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = text
   
        return dateFormatter.string(for: date)!
    }
}


