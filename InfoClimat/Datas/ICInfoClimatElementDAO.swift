//
//  ICInfoClimatElementDAO.swift
//  InfoClimat
//
//  Created by Christian Gaiola on 05/11/2017.
//  Copyright © 2017 LeBonCoin. All rights reserved.
//

import Foundation

class ICInfoClimatElementDAO {
    static let sharedInstance = ICInfoClimatElementDAO()

    let cacheFileName = "cache.json"
    
    /**
     Get ICInfoClimatElement from cache if possible
     
     - returns : an array of ICInfoClimatElement contained in cache
     */
    func getElementsFromCache() -> Array<ICInfoClimatElement> {
        var infoClimatElements = Array<ICInfoClimatElement>()
        
        let userDocumentsFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let cachePath = userDocumentsFolder?.appendingPathComponent(cacheFileName)
            else {
                print("Can't access cache path")
                return infoClimatElements
            }
        
        do {
            let data = try Data(contentsOf: cachePath, options: .mappedIfSafe)
            if let json = try JSONSerialization.jsonObject(with: data, options:[]) as? [String:AnyObject] {
                infoClimatElements = ICInfoClimatElementFactory.sharedInstance.getInfoClimatElements(fromJson: json);
            }

        } catch {
            print("Exception trhown while trying to get cache datas. Nothing in cache ?")
        }
        
        return infoClimatElements
    }
    
    /**
     Write a json string in cache
     
     - parameter json : the Json string containing elements to write in cache
     */
    func saveJsonInCache(_ json:Data) {
        let userDocumentsFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        guard let cachePath = userDocumentsFolder?.appendingPathComponent(cacheFileName)
            else {
                print("Can't access cache path")
                return
            }
        
        do {
            try json.write(to: cachePath, options:.atomic)
        }
        catch {
            print("Exception trhown while trying to save datas to cache")
        }
    }
}
