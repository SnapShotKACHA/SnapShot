//
//  GroupCell.swift
//  SnapShot
//
//  Created by Jacob Li on 12/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class GroupCell: UITableViewCell {
    
    @IBOutlet weak var groupCellImageView: UIImageView!
    
    @IBOutlet weak var groupCellTitleLabel: UILabel!
    
    @IBOutlet weak var groupCellPriceLabel: UILabel!
    
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var groupCellTimeLabel: UILabel!
    
    @IBOutlet weak var groupCellLocationLabel: UILabel!
    @IBOutlet weak var groupCellServiceLabel: UILabel!
    
    @IBOutlet weak var groupCellMemberNumLabel: UILabel!
    
    @IBOutlet weak var groupCellPhotographerLabel: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    
    @IBOutlet weak var commentBtn: UIButton!
    
    @IBOutlet weak var repostBtn: UIButton!
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}