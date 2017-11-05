//
//  ICInfoClimatElement.swift
//  InfoClimat
//
//  Created by Christian Gaiola on 05/11/2017.
//  Copyright © 2017 LeBonCoin. All rights reserved.
//

import Foundation

class ICInfoClimatElement {
    var date : Date
    /**
     Temperature in Kelvin
     */
    var temperature : Double?
    
    /**
     Rain in mm
     */
    var pluie : Double?
    
    /**
     Humidity in %
     */
    var humidite : Double?
    
    /**
     Wind in km/h
     */
    var vent : Double?
    
    /**
     Nebulosity in %
     */
    var nebulosite : Double?
    
    /**
     Snow risk : yes/no
     */
    var risqueNeige : Bool?
    
    /**
     Temperature in Celsius
     */
    var temperatureCelsius : Double? {
        if temperature != nil
        {
            return temperature! - 273.15
        }
        return nil
    }
    
    /**
     Init a ICInfoClimatElement with a date
     - parameter date: Date for the ICInfoClimatElement
     */
    init(forDate date:Date) {
        self.date = date
    }
    
    /**
     Init a ICInfoClimatElement with every elements
     
     - parameter date : Date for the ICInfoClimatElement
     - parameter temperature : Temperature for the ICInfoClimatElement
     - parameter pluie : Rain for the ICInfoClimatElement
     - parameter humidite : Humidity for the ICInfoClimatElement
     - parameter vent : Wind for the ICInfoClimatElement
     - parameter nebulosite : Nebulosity for the ICInfoClimatElement
     - parameter risqueNeige : SnowRisk for the ICInfoClimatElement
     */
    init(forDate date:Date, temperature:Double, pluie:Double, humidite:Double, vent:Double, nebulosite:Double, risqueNeige:Bool) {
        self.date = date
        self.temperature = temperature
        self.pluie = pluie
        self.humidite = humidite
        self.vent = vent
        self.nebulosite = nebulosite
        self.risqueNeige = risqueNeige
    }
}
