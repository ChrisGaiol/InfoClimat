//
//  ICInfoClimatElementMockDatas.swift
//  InfoClimat
//
//  Created by Christian Gaiola on 05/11/2017.
//  Copyright © 2017 LeBonCoin. All rights reserved.
//

import Foundation

class ICInfoClimatElementMock {
    static var infoClimatElement1 = ICInfoClimatElement(forDate: Date(dateAndTimeString:"2017-11-03 10:00:00"),
                                                         temperature: 280.5,
                                                         pluie: 0,
                                                         humidite: 20,
                                                         vent: 40,
                                                         nebulosite: 15,
                                                         risqueNeige: false)
    
    static var infoClimatElement2 = ICInfoClimatElement(forDate: Date(dateAndTimeString:"2017-11-03 12:00:00"),
                                                         temperature: 287,
                                                         pluie: 0,
                                                         humidite: 25,
                                                         vent: 20,
                                                         nebulosite: 55,
                                                         risqueNeige: false)
    
    static var infoClimatElement3 = ICInfoClimatElement(forDate: Date(dateAndTimeString:"2017-11-04 10:00:00"),
                                                         temperature: 278.2,
                                                         pluie: 0.5,
                                                         humidite: 100,
                                                         vent: 70,
                                                         nebulosite: 65,
                                                         risqueNeige: false)
    
    static var infoClimatElementArray = [infoClimatElement1, infoClimatElement2, infoClimatElement3];
}
