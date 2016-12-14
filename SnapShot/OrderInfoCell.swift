//
//  OrderInfoCell.swift
//  SnapShot
//
//  Created by Jacob Li on 16/12/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class OrderInfoCell: UITableViewCell {
   
    @IBOutlet weak var orderInfoCellServiceLabel: UILabel!
    @IBOutlet weak var orderInfoCellPhotorLabel: UILabel!
    @IBOutlet weak var orderInfoCellDateLabel: UILabel!
    @IBOutlet weak var orderInfoCellTimeLabel: UILabel!
    @IBOutlet weak var orderInfoCellLocationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
