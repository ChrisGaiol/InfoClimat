//
//  DateExtension.swift
//  InfoClimat
//
//  Created by Christian Gaiola on 05/11/2017.
//  Copyright © 2017 LeBonCoin. All rights reserved.
//

import Foundation

extension Date
{
    /**
     Init a Date with a string in "yyyy-MM-dd HH:mm:ss" format
     - returns : a new Date
     */
    init(dateAndTimeString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let d = dateStringFormatter.date(from:dateAndTimeString)!
        self.init(timeInterval:0, since:d)
    }
    
    /**
     Init a Date with a string in "yyyy-MM-dd" format
     - returns : a new Date
     */
    init(dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        
        let d = dateStringFormatter.date(from:dateString)!
        self.init(timeInterval:0, since:d)
    }
    
    /**
     Get a string containing only the date of the date in "yyyy-MM-dd" format
     - returns : a String containing only the date
     */
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: self)
    }
    
    /**
     Get a string containing only the time of the date in "HH:mm" format
     - returns : a String containing only the time
     */
    func getTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: self)
    }
    
    /**
     Get the real name of the day
     - returns : a String containing the real name of the day
     */
    func getDayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EEEE"
        
        return dateFormatter.string(from:self)
    }
    
    /**
     Get the name of the day with common terms like Today or Tomorrow
     - returns : A String containing the name of the day
     */
    func getDayLibelle() -> String {
        let date = Date(dateString: self.getDateString())
        let todayDate = Date(dateString:Date().getDateString())
        let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: todayDate)
        
        if todayDate == date
        {
            return "today"
        }
        else if tomorrowDate == date
        {
            return "tomorrow"
        }
        else
        {
            return self.getDayString()
        }
    }
}
