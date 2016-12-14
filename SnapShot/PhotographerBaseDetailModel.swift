//
//  PhotographerBaseDetailModel.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/21.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhotographerBaseDetailModel: BaseModel {
    
    fileprivate var appointmentCount: String?; // 预约数量
    fileprivate var intro: String?;
    fileprivate var collectCount: String?; // 收藏数量
    fileprivate var priceTendency: String?; // 应该是JsonArray的形式，目前不会解析
    fileprivate var photograopherId: String?;
    fileprivate var serveCity: String?
    fileprivate var skill: String?; // 擅长领域
    fileprivate var likeCount: String?; // 点赞数量
    
    override init() {
        appointmentCount = ""
        collectCount = ""
        priceTendency = ""
        intro = ""
        photograopherId = ""
        serveCity = ""
        skill = ""
        likeCount = ""
    }
    
    override func parseJson(_ object: AnyObject) {
        super.parseJson(object)
        appointmentCount = JSON(object)[JSON_KEY_APPOINTMENT_COUNT].string
        collectCount = JSON(object)[JSON_KEY_COLLECT_COUNT].string
        priceTendency = JSON(object)[JSON_KEY_PRICE_TENDENCY].string
        intro = JSON(object)[JSON_KEY_INTRO].string
        photograopherId = JSON(object)[JSON_KEY_PHOTOGRAPHER_ID].string
        serveCity = JSON(object)[JSON_KEY_SERVE_CITY].string
        skill = JSON(object)[JSON_KEY_SKILL].string
        likeCount = JSON(object)[JSON_KEY_LIKE_COUNT].string

    }
    
    /*
        获取服务城市
    */
    func getServeCity() -> String {
        return self.serveCity!
    }
    
    /*
        获取擅长领域
    */
    func getSkill() -> String {
        return self.skill!
    }
    
    /*
        获取点赞数量
    */
    func getLikeCount() -> String {
        return self.likeCount!
    }
    
    /*
        获取预约数量
    */
    func getAppointmentCount() -> String {
        return self.appointmentCount!
    }
    
    /*
        获取用户收藏数量
    */
    func getCollectCount() -> String {
        return self.collectCount!
    }
    
    /*
        获取摄影师身价走势
    */
    func getPriceTendency() -> String {
        return self.priceTendency!
    }
    
    /*
        获取摄影师Id
    */
    func getPhotograopherId() -> String {
        return self.photograopherId!
    }
    
    /*
        获取摄影师简介
    */
    func getIntro() -> String {
        return self.intro!
    }
    
}
