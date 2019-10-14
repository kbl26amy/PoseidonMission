//
//  PoseidonMissionTests.swift
//  PoseidonMissionTests
//
//  Created by 楊雅涵 on 2019/10/12.
//  Copyright © 2019 AmyYang. All rights reserved.
//

import XCTest
@testable import PoseidonMission
class PoseidonMissionTests: XCTestCase {
   
    let earlyDate = Date(timeIntervalSince1970: 1)
    let todayDate = Date(timeIntervalSince1970: 1570950191)
    let zeroDate = Date(timeIntervalSince1970: 1570838400)
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testdateToString(date:Date,
                                 text: String = "yyyy-MM-dd")
            -> String {
    
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = text
       
            return dateFormatter.string(from: date)
        }
    
    func testToday() {
        XCTAssert(testdateToString(date: todayDate) == "2019-10-13", "日期正確")
        XCTAssert(testdateToString(date: earlyDate) == "1970-01-01", "日期正確")
        XCTAssert(testdateToString(date: zeroDate) == "2019-10-12", "日期正確")
    }

}
