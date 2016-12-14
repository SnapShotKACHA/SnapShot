//
//  PhotographerProductModel.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/21.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhotographerProductModel: BaseModel {
    
    fileprivate var commentCount: String?; // 收藏数量
    fileprivate var picUrl: String?;
    fileprivate var workId: String?; // 擅长领域
    fileprivate var likeCount: String?; // 点赞数量
    
    override init() {
        commentCount = ""
        picUrl = ""
        workId = ""
        likeCount = ""
    }
    
    override func parseJson(_ object: AnyObject) {
        super.parseJson(object)
        commentCount = JSON(object)[JSON_KEY_COMMENT_COUNT].string
        picUrl = JSON(object)[JSON_KEY_PIC_URL].string
        workId = JSON(object)[JSON_KEY_WORD_ID].string
        likeCount = JSON(object)[JSON_KEY_LIKE_COUNT].string
    }
    
    /*
        获取点赞数量
    */
    func getLikeCount() -> String {
        return self.likeCount!
    }
    
    /*
        获取评论数量
    */
    func getCommentCount() -> String {
        return self.commentCount!
    }
    
    /*
        获取作品id
    */
    func getWorkId() -> String {
        return self.workId!
    }
    
    /*
        获取图片URL
    */
    func getPicUrl() -> String {
        return self.picUrl!
    }
    
}
