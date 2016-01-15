//
//  SpecialShotDetailModel.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/14.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class SpecailShotDetailModel: BaseModel {
    
    var picUrl: String?;
    var price: String?;
    var title: String?;
    var abstract: String?;
    var shotId: String?;
    var summary: String?;
    var date: String?;
    var location: String?;
    var service: String?;
    var sculpt: String?; // 造型
    var likeCount: String?; // 点赞数量
    var commentsCount: String?; // 评论数量
    var photographer: String?; // 摄影师，{头像，id}

    
    override init() {
        picUrl = ""
        price = ""
        title = ""
        abstract = ""
        shotId = ""
        summary = ""
        date = ""
        location = ""
        service = ""
        sculpt = ""
        likeCount = ""
        commentsCount = ""
        photographer = ""
    }
    
    override func parseJson(object: AnyObject) {
        super.parseJson(object)
        picUrl = JSON(object)[JSON_KEY_PIC_URL].string
        price = JSON(object)[JSON_KEY_PRICE].string
        title = JSON(object)[JSON_KEY_TITLE].string
        abstract = JSON(object)[JSON_KEY_ABSTRACT].string
        shotId = JSON(object)[JSON_KEY_SHOT_ID].string        
        summary = JSON(object)[JSON_KEY_SUMMARY].string
        date = JSON(object)[JSON_KEY_DATE].string
        location = JSON(object)[JSON_KEY_LOCATION].string
        service = JSON(object)[JSON_KEY_SERVICE].string
        sculpt = JSON(object)[JSON_KEY_SCULPT].string
        likeCount = JSON(object)[JSON_KEY_LIKE_COUNT].string
        commentsCount = JSON(object)[JSON_KEY_COMMENTS_COUNT].string
        photographer = JSON(object)[JSON_KEY_PHOTOGRAPHER].string
        
    }
    
}