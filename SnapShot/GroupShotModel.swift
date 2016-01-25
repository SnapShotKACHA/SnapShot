//
//  GroupShotModel.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/25.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class GroupShotModel: BaseModel {
    
    private var picUrl: String?;
    private var price: String?;
    private var title: String?;
    private var intro: String?;
    private var shotId: String?;
    private var startTime: String?;
    private var endTime: String?;
    private var minNumber: String?;
    private var maxNumber: String?;
    private var likeCount: String?;
    private var commentCount: String?;
    private var photographerCount: String?;
    private var location: String?;
    
    override init() {
        picUrl = ""
        price = ""
        title = ""
        intro = ""
        shotId = ""
        location = ""
        likeCount = ""
        startTime = ""
        commentCount = ""
        endTime = ""
        maxNumber = ""
        minNumber = ""
        photographerCount = ""
    }
    
    override func parseJson(object: AnyObject) {
        super.parseJson(object)
        picUrl = JSON(object)[JSON_KEY_PIC_URL].string
        price = JSON(object)[JSON_KEY_PRICE].string
        title = JSON(object)[JSON_KEY_TITLE].string
        intro = JSON(object)[JSON_KEY_INTRO].string
        shotId = JSON(object)[JSON_KEY_SHOT_ID].string
        location = JSON(object)[JSON_KEY_LOCATION].string
        likeCount = JSON(object)[JSON_KEY_LIKE_COUNT].string
        startTime = JSON(object)[JSON_KEY_PHOTOGRAPHER_ID].string
        commentCount = JSON(object)[JSON_KEY_COMMENTS_COUNT].string
        endTime = JSON(object)[JSON_KEY_APPOINTMENT_COUNT].string
        maxNumber = JSON(object)[JSON_KEY_PHOTOGRAPHER_ID].string
        photographerCount = JSON(object)[JSON_KEY_COMMENTS_COUNT].string
        minNumber = JSON(object)[JSON_KEY_APPOINTMENT_COUNT].string
    }
    
    /*
     * 最大参团人数或家庭数
     */
    func getMaxNumber() -> String {
        return self.maxNumber!
    }
    
    /*
     * 最少参团人说或家庭数
     */
    func getMinNumber() -> String {
        return self.minNumber!
    }
    
    /*
     * 活动地点，如奥体公园
     */
    func getLocation() -> String {
        return self.location!
    }
    
    /*
     * 点赞数量
     */
    func getLikeCount() -> String {
        return self.likeCount!
    }
    
    /*
     * 摄影师数量
     */
    func getPhotographerCount() -> String {
        return self.photographerCount!
    }
    
    /*
     * 评论数量
     */
    func getCommentCount() -> String {
        return self.commentCount!
    }
    
    /*
     * 活动开始时间
     */
    func getStartTime() -> String {
        return self.startTime!
    }
    
    /*
     * 活动结束时间
     */
    func getEndTime() -> String {
        return self.endTime!
    }
    
    /*
     * 图片地址
     */
    func getPicUrl() -> String {
        return self.picUrl!
    }
    
    /*
     * 活动Id
     */
    func getShotId() -> String {
        return self.shotId!
    }
    
    /*
     * 拍摄价格
     */
    func getPrice() -> String {
        return self.price!
    }
    
    /*
     * 活动简介、服务内容
     */
    func getIntro() -> String {
        return self.intro!
    }
    
    /*
     * 活动名称
     */
    func getTitle() -> String {
        return self.title!
    }
    
}