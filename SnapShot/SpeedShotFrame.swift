//
//  SpeedShotFrame.swift
//  SnapShot
//
//  Created by Jacob Li on 13/01/2016.
//  Copyright © 2016 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class SpeedShotFrame: UIView {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var startSpeedShotButton: UIButton!
    let defaultFrame = CGRectMake(0, SCREEN_HEIGHT - 160, SCREEN_WIDTH, 160)
    
    @IBAction func startSpeedShotButtonAction(sender: AnyObject) {
    }

    init(infoDic :Dictionary<String, String>) {
        super.init(frame: defaultFrame)
        if infoDic.count != 0 {
//            self.locationLabel.text = infoDic["location"]
//            self.priceLabel.text = infoDic["price"]
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}