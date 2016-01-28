//
//  SpecialShotDetailModel.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/14.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class SpecialShotDetailModel: BaseModel {
    
    private var picUrls: String?;
    private var price: String?;
    private var title: String?;
    private var intro: String?;
    private var shotId: String?;
    private var summary: String?;
    private var date: String?;
    private var location: String?;
    private var service: String?;
    private var sculpt: String?; // 造型
    private var likeCount: String?; // 点赞数量
    private var commentCount: String?; // 评论数量
    private var photographers: String?; // 摄影师，{头像，id}

    override init() {
        picUrls = ""
        price = ""
        title = ""
        intro = ""
        shotId = ""
        summary = ""
        date = ""
        location = ""
        service = ""
        sculpt = ""
        likeCount = ""
        commentCount = ""
        photographers = ""
    }
    
    override func parseJson(object: AnyObject) {
        super.parseJson(object)
        picUrls = JSON(object)[JSON_KEY_PIC_URLS].string
        price = JSON(object)[JSON_KEY_PRICE].string
        title = JSON(object)[JSON_KEY_TITLE].string
        intro = JSON(object)[JSON_KEY_INTRO].string
        shotId = JSON(object)[JSON_KEY_SHOT_ID].string        
        summary = JSON(object)[JSON_KEY_SUMMARY].string
        date = JSON(object)[JSON_KEY_DATE].string
        location = JSON(object)[JSON_KEY_LOCATION].string
        service = JSON(object)[JSON_KEY_SERVICE].string
        sculpt = JSON(object)[JSON_KEY_SCULPT].string
        likeCount = JSON(object)[JSON_KEY_LIKE_COUNT].string
        commentCount = JSON(object)[JSON_KEY_COMMENT_COUNT].string
        photographers = JSON(object)[JSON_KEY_PHOTOGRAPHERS].string
    }
    
    func getPhotographers() -> String {
        return self.photographers!
    }
    
    func getCommentCount() -> String {
        return self.commentCount!
    }
    
    func getLikeCount() -> String {
        return self.likeCount!
    }
    
    func getSculpt() -> String {
        return self.sculpt!
    }
    
    func getService() -> String {
        return self.service!
    }
    
    func getLocation() -> String {
        return self.location!
    }
    
    func getDate() -> String {
        return self.date!
    }
    
    func getSummary() -> String {
        return self.summary!
    }

    func getShotId() -> String {
        return self.shotId!
    }
    
    func getIntro() -> String {
        return self.intro!
    }
    
    func getTitle() -> String {
        return self.title!
    }
    
    func getPrice() -> String {
        return self.price!
    }
    
    func getPicUrls() -> String {
        return self.picUrls!
    }
    
}