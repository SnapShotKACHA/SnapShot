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
    
    fileprivate var picUrl: String?;
    fileprivate var price: String?;
    fileprivate var title: String?;
    fileprivate var intro: String?;
    fileprivate var shotId: String?;
    
    init(picUrlValue: String, priceValue: String, titleValue: String, introValeu: String) {
        picUrl = picUrlValue
        price = priceValue
        title = titleValue
        intro = introValeu
        shotId = ""
    }
    
    override func parseJson(_ object: AnyObject) {
        super.parseJson(object)
        picUrl = JSON(object)[JSON_KEY_PIC_URL].string
        price = JSON(object)[JSON_KEY_PRICE].string
        title = JSON(object)[JSON_KEY_TITLE].string
        intro = JSON(object)[JSON_KEY_INTRO].string
        shotId = JSON(object)[JSON_KEY_SHOT_ID].string
    }
    
    func getPicUrl() -> String {
        return self.picUrl!
    }
    
    func getShotId() -> String {
        return self.shotId!
    }
    
    func getPrice() -> String {
        return self.price!
    }
    
    func getTitle() -> String {
        return self.title!
    }
    
    func getIntro() -> String {
        return self.intro!
    }
    
}
