//
//  CommentCell.swift
//  SnapShot
//
//  Created by Jacob Li on 01/12/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var commentCellProfileImageView: UIImageView!
    @IBOutlet weak var commentCellUserIDLabel: UILabel!
    @IBOutlet weak var commentCellTimeLabe: UILabel!
    @IBOutlet weak var commentCellCommentLabel: UILabel!
    @IBOutlet weak var commentCellCommenButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func commentAction(sender: AnyObject) {
    }
}
