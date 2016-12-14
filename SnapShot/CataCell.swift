//
//  CataCell.swift
//  SnapShot
//
//  Created by Jacob Li on 05/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class CataCell: UITableViewCell {
    
    @IBOutlet weak var cataImageView: UIImageView!
    
    @IBOutlet weak var cataLabel: UILabel!
    
    @IBOutlet weak var cataIntroLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
