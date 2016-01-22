//
//  ServiceFeeFrame.swift
//  SnapShot
//
//  Created by Jacob Li on 19/01/2016.
//  Copyright © 2016 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class ServiceFeeFrame: UIView {
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var finishTime: UILabel!
    @IBOutlet weak var controledPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBAction func priceMinusButton(sender: AnyObject) {
        if Int(controledPriceLabel.text!) > 0 {
            controledPriceLabel.text = String(Int(controledPriceLabel.text!)! - 10)
            priceLabel.text = controledPriceLabel.text
        }
    }
    @IBAction func plusButtonAction(sender: AnyObject) {
        if Int(controledPriceLabel.text!) < 1000 {
            controledPriceLabel.text = String(Int(controledPriceLabel.text!)! + 10)
            priceLabel.text = controledPriceLabel.text
        }
    }

    
}