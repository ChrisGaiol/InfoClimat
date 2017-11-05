//
//  ICInfoClimatElementFactory.swift
//  InfoClimat
//
//  Created by Christian Gaiola on 05/11/2017.
//  Copyright © 2017 LeBonCoin. All rights reserved.
//

import Foundation

class ICInfoClimatElementFactory {
    static let sharedInstance = ICInfoClimatElementFactory()
    
    /**
     Get an ICInfoClimatElement array from a Json string
     
     - parameter json : the Json string containing parsed elements
     - returns : an array of ICInfoClimatElement
     */
    func getInfoClimatElements(fromJson json:Dictionary<String, Any>) -> Array<ICInfoClimatElement> {
        var listInfoClimat = Array<ICInfoClimatElement>()
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        for (key, value) in json {
            if let date = dateFormatterGet.date(from: key)  {
                if let root = value as? Dictionary<String, Any> {
                    if let infoClimat = getInfoClimatElement(forDate:date, withDictionary:root) {
                        listInfoClimat.append(infoClimat)
                    }
                }
            }
        }
        
        return listInfoClimat
    }
    
    /**
     Get an ICInfoClimatElement at a date from a Dictionnary
     
     - parameter date : the date of the infoClimatElement
     - parameter root : the dictionary containing the InfoClimatElement description
     - returns : an ICInfoClimatElement
     */
    func getInfoClimatElement(forDate date:Date, withDictionary root:Dictionary<String, Any>) -> ICInfoClimatElement? {
        let infoClimat = ICInfoClimatElement(forDate:date)
        // Get Temperature
        if let temperatures = root["temperature"] as? Dictionary<String, Any> {
            infoClimat.temperature = temperatures["sol"] as? Double
        }
        // Get Pluie
        if let pluie = root["pluie"] as? Double {
            infoClimat.pluie = pluie
        }
        // Get Humidite
        if let humidite = root["humidite"] as? Dictionary<String, Any> {
            infoClimat.humidite = humidite["2m"] as? Double
        }
        // Get vent
        if let ventMoyen = root["vent_moyen"] as? Dictionary<String, Any> {
            infoClimat.vent = ventMoyen["10m"] as? Double
        }
        // Get nebulosite
        if let nebulosite = root["nebulosite"] as? Dictionary<String, Any> {
            infoClimat.nebulosite = nebulosite["totale"] as? Double
        }
        // Get risqueNeige
        if let risqueNeige = root["risque_neige"] as? String {
            infoClimat.risqueNeige = risqueNeige == "oui"
        }
        return infoClimat;
    }
}
