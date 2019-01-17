//
//  DairyListItem.swift
//  CalendarTest
//
//  Created by Taeya on 2019/1/16.
//  Copyright © 2019 Taeya. All rights reserved.
//

import Foundation

class DairyListItem: NSObject, NSCoding {
    var Day = ""
    var Month = ""
    var Year = ""
    var Week = ""
    var DairyTitle = ""
    var DairyContent = ""
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        Day = aDecoder.decodeObject(forKey: "Day") as! String
        Month = aDecoder.decodeObject(forKey: "Month") as! String
        Year = aDecoder.decodeObject(forKey: "Year") as! String
        Week = aDecoder.decodeObject(forKey: "Week") as! String
        DairyTitle = aDecoder.decodeObject(forKey: "DairyTitle") as! String
        DairyContent = aDecoder.decodeObject(forKey: "DairyContent") as! String
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Day, forKey: "Day")
        aCoder.encode(Month, forKey: "Month")
        aCoder.encode(Year, forKey: "Year")
        aCoder.encode(Week, forKey: "Week")
        aCoder.encode(DairyTitle, forKey: "DairyTitle")
        aCoder.encode(DairyContent, forKey: "DairyContent")
        
    }
 
}
