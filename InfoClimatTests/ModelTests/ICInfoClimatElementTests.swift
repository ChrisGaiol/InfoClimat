//
//  ICInfoClimatElementTests.swift
//  InfoClimatTests
//
//  Created by Christian Gaiola on 05/11/2017.
//  Copyright © 2017 LeBonCoin. All rights reserved.
//

import XCTest

class ICInfoClimatElementTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitICInfoClimatElementByDate() {
        let date = Date()
        let infoClimatElement = ICInfoClimatElement(forDate:date)
        
        XCTAssertTrue(infoClimatElement.date == date)
        
    }
    
}
