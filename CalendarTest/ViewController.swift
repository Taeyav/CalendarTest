//
//  ViewController.swift
//  CalendarTest
//
//  Created by Taeya on 2019/1/14.
//  Copyright © 2019 Taeya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate{
    
    private weak var calendar: FSCalendar!
    override func loadView() {
        
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.groupTableViewBackground
        self.view = view
        
        let height: CGFloat = UIDevice.current.model.hasPrefix("iPad") ? 400 : 300
        let calendar = FSCalendar(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.frame.maxY, width: self.view.bounds.width, height: height))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.backgroundColor = UIColor.white //设置日历背景色
        calendar.appearance.headerTitleColor = UIColor.black //设置header标题字体颜色
        calendar.appearance.headerMinimumDissolvedAlpha = 0;//调整header前后月份标签静止时刻透明
        calendar.appearance.headerDateFormat = "yyyy年MM月"; //调整日历hear的年月格式
        calendar.appearance.weekdayTextColor = UIColor.black //设置星期抬头字体颜色
        calendar.appearance.caseOptions = FSCalendarCaseOptions(rawValue: 1 << 4);//通过FSCalendarAppearance.h找到需要的格式对应的值数 设置星期抬头格式
        calendar.allowsMultipleSelection = false; //不允许多选日期
        calendar.appearance.weekdayTextSize = 15;
        
        self.view.addSubview(calendar)
        self.calendar = calendar
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "日记"
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
}

