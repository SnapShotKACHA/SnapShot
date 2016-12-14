//
//  ProfileCell.swift
//  SnapShot
//
//  Created by Jacob Li on 23/10/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class DetailCell: UITableViewCell {
    
    @IBOutlet weak var serviceCity: UILabel!
    @IBOutlet weak var serviceCata: UILabel!
    @IBOutlet weak var personIntro: UILabel!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
