//
//  PhotographerCommentsModel.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/21.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhotographerCommentsModel: BaseModel {
    
    private var commentatorId: String?; // 发布评论的用户id
    private var avatar: String?; // 发布评论的用户头像
    private var nickname: String?; // 发布评论的用户昵称
    private var time: String?; // 评论的时间， 使用格林威治时间转换
    private var content: String?; // 评论具体内容
    
    override init() {
        commentatorId = ""
        avatar = ""
        nickname = ""
        time = ""
        content = ""
    }
    
    override func parseJson(object: AnyObject) {
        super.parseJson(object)
        commentatorId = JSON(object)[JSON_KEY_COMMENTATOR_ID].string
        avatar = JSON(object)[JSON_KEY_AVATAR].string
        nickname = JSON(object)[JSON_KEY_NICKNAME].string
        time = JSON(object)[JSON_KEY_TIME].string
        content = JSON(object)[JSON_KEY_CONTENT].string
    }
    
    /*
    获取发布评论的用户id
    */
    func getCommentatorId() -> String {
        return self.commentatorId!
    }
    
    /*
    获取头像URL
    */
    func getAvatar() -> String {
        return self.avatar!
    }
    
    /*
    获取发布评论的用户昵称
    */
    func getNickname() -> String {
        return self.nickname!
    }
    
    /*
    获取评论的时间， 使用格林威治时间转换
    */
    func getTime() -> String {
        return self.time!
    }
    
    /*
    获取评论具体内容
    */
    func getContent() -> String {
        return self.content!
    }
    
}