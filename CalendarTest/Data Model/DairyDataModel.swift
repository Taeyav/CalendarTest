//
//  DairyDataModel.swift
//  CalendarTest
//
//  Created by Taeya on 2019/1/16.
//  Copyright © 2019 Taeya. All rights reserved.
//

import Foundation

class DairyDataModel{
    var items = [DairyListItem]()
    
    init () {
        loadDairyListItems()
    }
    
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("DairyTableView.plist")
    }
    
    func loadDairyListItems() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            items = unarchiver.decodeObject(forKey: "DairyListItems") as! [DairyListItem]
            unarchiver.finishDecoding()
        }
    }
    
    func saveDairyListItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(items, forKey: "DairyListItems")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    
}
