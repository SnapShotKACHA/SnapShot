//
//  LowerCell.swift
//  SnapShot
//
//  Created by Jacob Li on 19/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit


class LowerCell: UITableViewCell {
    @IBOutlet weak var lowerCellTimeLabel: UILabel!
    @IBOutlet weak var lowerCellLocationLabel: UILabel!
    @IBOutlet weak var lowerCellServiceLabel: UILabel!
    @IBOutlet weak var lowerCellMembersLabel: UILabel!
    @IBOutlet weak var lowerCellPhotographerLabel: UILabel!
    @IBOutlet weak var lowerCellnfoLabel: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var repostBtn: UIButton!
    
    @IBOutlet weak var variableLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
