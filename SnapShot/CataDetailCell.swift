//
//  CataDetailCell.swift
//  SnapShot
//
//  Created by Jacob Li on 09/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class CataDetailCell: UITableViewCell {
    
    @IBOutlet weak var cataImage1: UIImageView!
   
    @IBOutlet weak var cataImage2: UIImageView!
    
    @IBOutlet weak var shadowImage1: UIImageView!
    
    @IBOutlet weak var shadowImage2: UIImageView!
    
    @IBOutlet weak var cataLabel1: UILabel!
    @IBOutlet weak var cataLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}