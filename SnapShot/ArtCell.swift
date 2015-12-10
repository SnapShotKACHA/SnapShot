//
//  ArtCell.swift
//  SnapShot
//
//  Created by Jacob Li on 01/12/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class ArtCell: UITableViewCell {
    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var artCellLikeBtn: UIButton!
    @IBOutlet weak var artCellLikeLabel: UILabel!
    @IBOutlet weak var artCellCommentBtn: UIButton!
    @IBOutlet weak var artCellCommentLabel: UILabel!
    @IBOutlet weak var repostBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func likeAction(sender: AnyObject) {
    }
    @IBAction func commentAction(sender: AnyObject) {
    }
    @IBAction func repostAction(sender: AnyObject) {
    }
    
    
}
