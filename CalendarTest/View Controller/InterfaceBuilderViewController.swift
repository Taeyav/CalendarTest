//
//  InterfaceBuilderViewController.swift
//  CalendarTest
//
//  Created by Taeya on 2019/1/14.
//  Copyright © 2019 Taeya. All rights reserved.
//

import UIKit

class InterfaceBuilderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DairyDetailViewControllerDelegate, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance{
    
    @IBOutlet weak var dairyListTable: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
   
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.full
        return formatter
    }()
    
    var dairyDataModel: DairyDataModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.8288275599, blue: 0, alpha: 1)
        
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calendarHeightConstraint.constant = 400
        }
        
        self.calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]//设置年月及Weekday标签样式
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0;//调整header前后月份标签静止时刻透明
        self.calendar.appearance.headerDateFormat = "yyyy年MM月"; //调整日历header的年月格式
        self.calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 20)
        
        //滑动手势相关（后续补充左右按钮事件可删除）
        let scopeGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        self.calendar.addGestureRecognizer(scopeGesture)
        
        
        //注册cell
        let cellNib = UINib(nibName: "DairyTableViewCell", bundle: nil)
        //设置重用ID
        dairyListTable.register(cellNib, forCellReuseIdentifier: "DairyListItem")
        //清楚分割线颜色
        dairyListTable.separatorColor = UIColor.clear
        
    }
    
    
    @IBAction func prevButton(_ sender: UIButton) {
        calendar.setCurrentPage(getPreviousMonth(date: calendar.currentPage), animated: true)
        print(calendar.currentPage)
        print("\(Calendar.current)")
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        calendar.setCurrentPage(getNextMonth(date: calendar.currentPage), animated: true)
        print(calendar.currentPage)
        print("\(Calendar.current)")
    }
   
    func getPreviousMonth(date:Date)->Date{
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    
    func getNextMonth(date:Date)->Date{
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
    //设置选择颜色 周末与工作日不同
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        let dayDate = self.dateFormatter2.string(from: date)
        let array = dayDate.components(separatedBy: ",")
        if array[0] == "Saturday" || array[0] == "Sunday"{
            return appearance.selectionColor
        }
        return #colorLiteral(red: 1, green: 0.8288275599, blue: 0, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //设置tableviewcell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    //设置c输出条数
    func tableView(_ tableView: UITableView, numberOfRowsInSection Section: Int) -> Int{
        return dairyDataModel.items.count
    }

    //设置cell具体内容
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dairyListTable.dequeueReusableCell(
            withIdentifier: "DairyListItem", for: indexPath)
        let item = dairyDataModel.items[indexPath.row]
        configureText(for: cell, with: item)
        return cell
    }
    
    func DairyDetailViewControllerDidBack(_ controller: DairyDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func configureText(for cell: UITableViewCell, with item: DairyListItem) {
        let dayLabel = cell.viewWithTag(1) as! UILabel
        let monthLabel = cell.viewWithTag(2) as! UILabel
        let yearLabel = cell.viewWithTag(3) as! UILabel
        let dairyTitleLabel = cell.viewWithTag(4) as! UILabel
        let dairyContentLabel = cell.viewWithTag(5) as! UILabel
        
        dayLabel.text = item.Day
        monthLabel.text = item.Month
        yearLabel.text = item.Year
        dairyTitleLabel.text = item.DairyTitle
        dairyContentLabel.text = item.DairyContent
    }
    
    func DairyDetailViewControllerDidCancle(_ controller: DairyDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func DairyDetailViewController(_ controller: DairyDetailViewController,
                                   didFinishAdding item: DairyListItem) {
        let newRowIndex = dairyDataModel.items.count
        dairyDataModel.items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        dairyListTable.insertRows(at: indexPaths, with: .automatic)
        
        dismiss(animated: true, completion: nil)
        //saveChecklistItems()
    }
    
    func DairyDetailViewController(_ controller: DairyDetailViewController,
                                  didFinishEditing item: DairyListItem) {
        if let index = dairyDataModel.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = dairyListTable.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        dismiss(animated: true, completion: nil)
        //saveChecklistItems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddDairy" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! DairyDetailViewController
            controller.delegate = self as! DairyDetailViewControllerDelegate
            
        } else if segue.identifier == "EditDairy" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! DairyDetailViewController
            controller.delegate = self as! DairyDetailViewControllerDelegate
            
            if let indexPath = dairyListTable.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = dairyDataModel.items[indexPath.row]
            }
        }
    }
}
