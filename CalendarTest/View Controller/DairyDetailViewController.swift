//
//  DairyDetailViewController.swift
//  CalendarTest
//
//  Created by Taeya on 2019/1/16.
//  Copyright © 2019 Taeya. All rights reserved.
//

import Foundation
import UIKit

protocol DairyDetailViewControllerDelegate: class {
    func DairyDetailViewControllerDidCancle(_ controller: DairyDetailViewController)
    func DairyDetailViewController(_ controller: DairyDetailViewController, didFinishAdding item: DairyListItem)
    func DairyDetailViewController(_ controller: DairyDetailViewController, didFinishEditing item: DairyListItem)
}

class DairyDetailViewController:UITableViewController, UITextFieldDelegate, UITextViewDelegate {
 
    @IBOutlet weak var dayDataLabel: UILabel!
    @IBOutlet weak var monthDataLabel: UILabel!
    @IBOutlet weak var yearDataLabel: UILabel!
    @IBOutlet weak var weekDataLabel: UILabel!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentView: UITextView!
    
    @IBOutlet weak var doneButton: UIButton!
    
    weak var delegate: DairyDetailViewControllerDelegate?
    
    var itemToEdit: DairyListItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.8288275599, blue: 0, alpha: 1)
        tableView.separatorColor = UIColor.clear
        
        if let item = itemToEdit {
            title = "编辑日记"
            dayDataLabel.text = item.Day
            yearDataLabel.text = item.Year
            monthDataLabel.text = item.Month
            titleField.text = item.DairyTitle
            contentView.text = item.DairyContent
            doneButton.isEnabled = true
        }
    }
    
    @IBAction func cancle(_ sender: Any) {
        delegate?.DairyDetailViewControllerDidCancle(self)
    }
    
    @IBAction func done(_ sender: Any) {
        if let item = itemToEdit {
            item.Day = "04"
            item.Year = "2019"
            item.Month = "01"
            item.DairyTitle = "生日快乐啦啦啦"
            item.DairyContent = "天才不头秃！！！"
            delegate?.DairyDetailViewController(self, didFinishEditing: item)
            
        } else {
            let item = DairyListItem()
            item.Day = "04"
            item.Year = "2019"
            item.Month = "01"
            item.DairyTitle = "生日快乐啦啦啦"
            item.DairyContent = "天才不头秃！！！"
//            item.dayLabel.text = dayData.text
//            item.yearLabel.text = yearData.text
//            item.monthLabel.text = monthData.text
//            item.dairyTitleLabel.text = TitleField.text!
//            item.dairyContentLabel.text = ContentView.text!
            delegate?.DairyDetailViewController(self, didFinishAdding: item)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        if newText.length > 0{
            doneButton.isEnabled = true
            return true
        }
        return false
    }
}

