//
//  DairyTableViewCell.swift
//  CalendarTest
//
//  Created by Taeya on 2019/1/15.
//  Copyright © 2019 Taeya. All rights reserved.
//

import UIKit

class DairyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var yearAndMonthLabel: UILabel!
    @IBOutlet weak var dairyTitleLabel: UILabel!
    @IBOutlet weak var dairyContentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
