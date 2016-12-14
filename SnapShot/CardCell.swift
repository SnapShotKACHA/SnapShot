//
//  CardCell.swift
//  SnapShot
//
//  Created by Jacob Li on 12/10/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class CardCell: UITableViewCell {
    
    
    @IBOutlet weak var displayImage: UIImageView!
    
    @IBOutlet weak var photographerIDLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
   
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setRateImages(_ upNum:Int) {
        for i in 0 ..< upNum {
            let rateImage:UIImageView = UIImageView(frame: CGRect(x: 190 + (20*i), y: 40, width: 15, height: 15))
            rateImage.image = UIImage(named: "upRateImage")
            self.addSubview(rateImage)
        }
        
        for i in 0 ..< (5-upNum) {
            let rateImage:UIImageView = UIImageView(frame: CGRect(x: 190 + (20*upNum) + (20*i), y: 40, width: 15, height: 15))
            rateImage.image = UIImage(named: "downRateImage")
            self.addSubview(rateImage)
        }
    }
}
