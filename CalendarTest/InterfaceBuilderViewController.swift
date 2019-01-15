//
//  InterfaceBuilderViewController.swift
//  CalendarTest
//
//  Created by Taeya on 2019/1/14.
//  Copyright © 2019 Taeya. All rights reserved.
//

import UIKit

class InterfaceBuilderViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calendarHeightConstraint.constant = 400
        }
        
        self.calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0;//调整header前后月份标签静止时刻透明
        self.calendar.appearance.headerDateFormat = "yyyy年MM月"; //调整日历header的年月格式
        self.calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 20)
        
        let scopeGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        self.calendar.addGestureRecognizer(scopeGesture)
        
//        // For UITest
//        self.calendar.accessibilityIdentifier = "calendar"
//
    }
    
}

