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
        
        XCTAssertEqual(infoClimatElement.date, date)
        
    }
    
    func testInitICInfoClimatElementFull() {
        let date = Date()
        let infoClimatElementSunnyDay = ICInfoClimatElement(forDate: date, temperature: 293.15, pluie: 0, humidite: 10, vent: 10, nebulosite: 10, risqueNeige: false)
        
        let infoClimatElementCloudyDay = ICInfoClimatElement(forDate: date, temperature: 280, pluie: 0, humidite: 10, vent: 10, nebulosite: 55, risqueNeige: false)
        
        let infoClimatElementRainyDay = ICInfoClimatElement(forDate: date, temperature: 280, pluie: 0.5, humidite: 10, vent: 10, nebulosite: 60, risqueNeige: false)
        
        XCTAssertEqual(infoClimatElementSunnyDay.date, date)
        XCTAssertEqual(infoClimatElementSunnyDay.temperature, 293.15)
        XCTAssertEqual(infoClimatElementSunnyDay.pluie, 0)
        XCTAssertEqual(infoClimatElementSunnyDay.humidite, 10)
        XCTAssertEqual(infoClimatElementSunnyDay.vent, 10)
        XCTAssertEqual(infoClimatElementSunnyDay.nebulosite, 10)
        XCTAssertEqual(infoClimatElementSunnyDay.risqueNeige, false)
        XCTAssertEqual(infoClimatElementSunnyDay.temperatureCelsius, 20)
        
        XCTAssertEqual(infoClimatElementSunnyDay.climatType, .sunny)
        XCTAssertEqual(infoClimatElementCloudyDay.climatType, .cloudy)
        XCTAssertEqual(infoClimatElementRainyDay.climatType, .rainy)
        
    }
    
}
