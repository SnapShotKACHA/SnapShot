//
//  PhotographerIntroduceModel.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/18.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhotographerIntroduceModel: BaseModel {
    
    private var picUrl: String?;
    private var price: String?;
    private var avatarUrl: String?;
    private var nickname: String?;
    private var publishDate: String?;
    private var location: String?;
    private var likeCount: String?;
    private var commentsCount: String?;
    private var photographerId: String?;
    private var appointmentCount: String?;
    
    override init() {
        picUrl = ""
        price = ""
        avatarUrl = ""
        nickname = ""
        publishDate = ""
        location = ""
        likeCount = ""
        photographerId = ""
        commentsCount = ""
        appointmentCount = ""
    }
    
    override func parseJson(object: AnyObject) {
        super.parseJson(object)
        picUrl = JSON(object)[JSON_KEY_PIC_URL].string
        price = JSON(object)[JSON_KEY_PRICE].string
        avatarUrl = JSON(object)[JSON_KEY_TITLE].string
        nickname = JSON(object)[JSON_KEY_INTRO].string
        publishDate = JSON(object)[JSON_KEY_SHOT_ID].string        
        location = JSON(object)[JSON_KEY_LOCATION].string
        likeCount = JSON(object)[JSON_KEY_LIKE_COUNT].string
        photographerId = JSON(object)[JSON_KEY_PHOTOGRAPHER_ID].string
        commentsCount = JSON(object)[JSON_KEY_COMMENTS_COUNT].string
        appointmentCount = JSON(object)[JSON_KEY_APPOINTMENT_COUNT].string
    }
    
    func getLocation() -> String {
        return self.location!
    }
    
    func getLikeCount() -> String {
        return self.likeCount!
    }
    
    func getPhotographerId() -> String {
        return self.photographerId!
    }
    
    func getCommentsCount() -> String {
        return self.commentsCount!
    }
    
    func getAppointmentCount() -> String {
        return self.appointmentCount!
    }
    
    func getPicUrl() -> String {
        return self.picUrl!
    }
    
    func getPublishDate() -> String {
        return self.publishDate!
    }
    
    func getPrice() -> String {
        return self.price!
    }
    
    func getNickname() -> String {
        return self.nickname!
    }
    
    func getAvatarUrl() -> String {
        return self.avatarUrl!
    }
    
}