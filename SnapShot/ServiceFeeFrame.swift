//
//  ServiceFeeFrame.swift
//  SnapShot
//
//  Created by Jacob Li on 19/01/2016.
//  Copyright © 2016 Jacob Li. All rights reserved.
//

import Foundation
import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ServiceFeeFrame: UIView {
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var finishTime: UILabel!
    @IBOutlet weak var controledPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBAction func priceMinusButton(_ sender: AnyObject) {
        if Int(controledPriceLabel.text!) > 0 {
            controledPriceLabel.text = String(Int(controledPriceLabel.text!)! - 10)
            priceLabel.text = controledPriceLabel.text
        }
    }
    @IBAction func plusButtonAction(_ sender: AnyObject) {
        if Int(controledPriceLabel.text!) < 1000 {
            controledPriceLabel.text = String(Int(controledPriceLabel.text!)! + 10)
            priceLabel.text = controledPriceLabel.text
        }
    }

    
}
