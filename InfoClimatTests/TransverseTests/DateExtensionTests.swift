//
//  DateExtensionTests.swift
//  InfoClimatTests
//
//  Created by Christian Gaiola on 05/11/2017.
//  Copyright © 2017 LeBonCoin. All rights reserved.
//

import XCTest

class DateExtensionTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDateExtension () {
        let dateString          = "2017-11-05"
        let dateAndTimeString   = "2017-11-05 15:05:00"
        let timeString          = "15:05"
        let dayString           = "sunday"
        let todayString         = "today"
        
        let date        = Date(dateString:dateString)
        let dateAndTime = Date(dateAndTimeString:dateAndTimeString)
        let today       = Date()
        
        XCTAssertEqual(dateString, date.getDateString())
        XCTAssertEqual(dateString, dateAndTime.getDateString())
        XCTAssertEqual(timeString, dateAndTime.getTimeString())
        XCTAssertEqual(dayString.uppercased(), date.getDayString().uppercased()) // Check if 05 Nov. returns Sunday
        XCTAssertEqual(todayString.uppercased(), today.getDayLibelle().uppercased()) // Check today's date returns Today
    }
    
}
