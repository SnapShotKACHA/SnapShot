//
//  SpeedShotOrderCell.swift
//  SnapShot
//
//  Created by Jacob Li on 18/01/2016.
//  Copyright © 2016 Jacob Li. All rights reserved.
//

import UIKit

class SpeedShotOrderCell: UITableViewCell {
    
    @IBOutlet weak var SSordeCellProfileImageView: UIImageView!
    @IBOutlet weak var SSorderCellUserIdLabel: UILabel!
    @IBOutlet weak var SSorderCellTimeLabel: UILabel!
    @IBOutlet weak var SSorderCellDistanceLabel: UILabel!
    @IBOutlet weak var getOrderButton: UIButton!
 
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
