//
//  SpecailShotModel.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/14.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class SpecialShotModel: BaseModel {
    
    var picUrl: String?;
    var price: String?;
    var title: String?;
    var abstract: String?;
    var shotId: String?;
    
    override init() {
        picUrl = ""
        price = ""
        title = ""
        abstract = ""
        shotId = ""
    }
    
    override func parseJson(object: AnyObject) {
        super.parseJson(object)
        picUrl = JSON(object)[JSON_KEY_PIC_URL].string
        price = JSON(object)[JSON_KEY_PRICE].string
        title = JSON(object)[JSON_KEY_TITLE].string
        abstract = JSON(object)[JSON_KEY_INTRO].string
        shotId = JSON(object)[JSON_KEY_SHOT_ID].string
    }
    
}