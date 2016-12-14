//
//  CouponCell.swift
//  SnapShot
//
//  Created by RANRAN on 02/12/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class CouponCell: UITableViewCell {
    
    @IBOutlet weak var couponValueLabel: UILabel!
    @IBOutlet weak var couponConditionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
