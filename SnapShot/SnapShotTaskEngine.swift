//
//  SnapShotTaskEngine.swift
//  SnapShot
//
//  Created by 张磊 on 15/12/10.
//  Copyright © 2015年 Jacob Li. All rights reserved.
//

import Foundation

class SnapShotTaskEngine {
    
    class func getInstance() -> SnapShotTaskEngine! {
        struct SnapShotSingleton {
            static var predicate: dispatch_once_t = 0
            static var instance: SnapShotTaskEngine? = nil
        }
        dispatch_once(&SnapShotSingleton.predicate, {SnapShotSingleton.instance = SnapShotTaskEngine()})
        return SnapShotSingleton.instance
    }
    
    /*
     * 用户注册   
     * phoneNum, string, 手机号码
     * username, string, 用户名
     * password, string, 用户原始密码经md5加密后的字符串
     * authCode, string, 手机验证码
     */
    func doRegister(username: String!,
        phoneNum: String!,
        password: String!,
        verifyCode: String!,
        engineProtocol:SnapShotEngineProtocol!) -> Int! {
        let registerTask: RegisterTask = RegisterTask(username: username,
            phoneNum: phoneNum,
            password: password,
            verifyCode: verifyCode,
            engineProtocol: engineProtocol);
        print("SnapShotTaskEngine, register task start, taskID = \(registerTask.taskID)")
        return registerTask.taskID
    }
    
    /*
     * 登录成功后，SnapShotEngineProtocol中onTaskSuccess方法，返回LoginModel
     * 可根据uid查找用户信息
     */
    func doLogin(username:String?,
        phoneNum: String?,
        password: String!,
        engineProtocol: SnapShotEngineProtocol!) -> Int! {
        let loginTask: LoginTask = LoginTask(username: username,
            phoneNum: phoneNum,
            password: password,
            engineProtocol: engineProtocol);
        print("SnapShotTaskEngine, login task start, taskID = \(loginTask.taskID)")
        return loginTask.taskID
    }
    
    func doGetVerifyCode(phoneNum: String!, engineProtocol: SnapShotEngineProtocol!) -> Int! {
        let getVerifyCodeTask: GetSMSVerifyCodeTask = GetSMSVerifyCodeTask(phoneNum: phoneNum,
            engineProtocol: engineProtocol);
        print("SnapShotTaskEngine, GetVerifyCode task start, taskID = \(getVerifyCodeTask.taskID)")
        return getVerifyCodeTask.taskID
    }
    
    /**
     * 获取用户基本信息
     * method: Http.GET
     * path: /user/info/get
     * uid, long, 用户id
     * need test
     */
    func doGetUserInfoTask(userId: String!, engineProtocol: SnapShotEngineProtocol!) -> Int! {
        let getUserInfoTask: GetUserInfoTask = GetUserInfoTask(userId: userId, engineProtocol: engineProtocol);
        print("SnapShotTaskEngine, getUserInfoTask task start, taskID = \(getUserInfoTask.taskID)")
        return getUserInfoTask.taskID
    }
    
    /**
     * 修改用户名
     * path: /user/name/mod
     * uid, long, 用户id
     * newName, string, 新的用户名
     * secretKey 用户密码，经过两次md5加密
     * need test
     */
    func doModifyUserNameTask(newName: String!,
        uid:String!,
        secretKey: String!,
        engineProtocol: SnapShotEngineProtocol!) -> Int! {
        let modifyUserNameTask: ModifyUserNameTask = ModifyUserNameTask(newName: newName, uid: uid, secretKey: secretKey, engineProtocol: engineProtocol);
        print("SnapShotTaskEngine, ModifyUserNameTask task start, taskID = \(modifyUserNameTask.taskID)")
        return modifyUserNameTask.taskID
    }
    
    /**
     * 修改密码
     * path: /user/password/mod
     * phoneNum, string, 手机号码
     * password, string, 用户新密码经md5加密后的字符串
     * authCode, string, 手机验证码
     * secretKey 用户密码，经过两次md5加密
     * need test
     */
    func doModifyPasswordTask(phoneNum: String!,
        password: String!,
        authCode: String!,
        secretKey: String!,
        engineProtocol: SnapShotEngineProtocol!) -> Int! {
        let modifyPasswordTask: ModifyPasswordTask = ModifyPasswordTask(phoneNum: phoneNum,
            password: password,
            authCode: authCode,
            secretKey: secretKey,
            engineProtocol: engineProtocol);
        print("SnapShotTaskEngine, ModifyPasswordTask task start, taskID = \(modifyPasswordTask.taskID)")
        return modifyPasswordTask.taskID
    }
    
    /**
    * ## 用户报名参加团拍
    * path：/groupShot/enroll
    * paras:    
    * uid, long, 用户ID
    * shotId, long, 团拍活动id
    * secretKey 用户密码，经过两次md5加密
    * need test
    */
    func doEnrollGroupShotTask(shotId: String!,
        uid:String!,
        secretKey: String!,
        engineProtocol: SnapShotEngineProtocol!) -> Int! {
        let enrollGroupShot: EnrollGroupShotTask = EnrollGroupShotTask(shotId: shotId,
            uid: uid, secretKey: secretKey, engineProtocol: engineProtocol);
        print("SnapShotTaskEngine, EnrollGroupShot task start, taskID = \(enrollGroupShot.taskID)")
        return enrollGroupShot.taskID
    }
    
    /**
     * 获取首页推荐特色服务
     * path：--
     * paras:
     * uid, 用户ID, 可选
     * longitude, 经度, 可选
     * latitude, 维度, 可选
     * return extraData: SpecialShotModel
     * need test
     */
    func doGetRecommendedSpecialShot(userId: String!,
        longitude: String!,
        latitude: String!,
        engineProtocol: SnapShotEngineProtocol!) -> Int! {
        let getRecommendedShotTask: GetRecommendedSpecialShotTask = GetRecommendedSpecialShotTask(uid: userId,
            longitude: longitude,
            latitude: latitude,
            engineProtocol: engineProtocol);
        print("SnapShotTaskEngine, GetRecommendedShotTask task start, taskID = \(getRecommendedShotTask.taskID)")
        return getRecommendedShotTask.taskID
    }
    
    /**
     * 获取特色服务详情
     * path：--
     * paras:
     * shotId：活动Id
     * return extraData: SpecailShotDetailModel
     * need test
     */
    func doGetSpecialShotDetailTask(shotId: String!, engineProtocol: SnapShotEngineProtocol!) -> Int! {
        let getSpecialShotDetailTask: GetSpecialShotDetailTask = GetSpecialShotDetailTask(shotId: shotId,
            engineProtocol: engineProtocol);
        print("SnapShotTaskEngine, GetSpecialShotDetailTask task start, taskID = \(getSpecialShotDetailTask.taskID)")
        return getSpecialShotDetailTask.taskID
    }
    
    /**
     * 获取特色服务详情
     * path：--
     * paras:
     * uid：用户id，可选
     * longitude：经度，double，可选
     * latitude：维度，double，可选
     * page：请求的页数
     * step：每页多少条
     * return extraData: --
     * need test
     */
    func doGetRecommendedPhotographerTask(uid: String!,
        longitude: String!,
        latitude: String!,
        page: String!,
        step: String!,
        engineProtocol: SnapShotEngineProtocol!) -> Int! {
        let getRecommendedPhotographerTask: GetRecommendedPhotographerTask = GetRecommendedPhotographerTask(uid: uid!,
            longitude: longitude!,
            latitude: latitude!,
            page: page!,
            step: step!,
            engineProtocol: engineProtocol);
        print("SnapShotTaskEngine, GetRecommendedPhotographerTask task start, taskID = \(getRecommendedPhotographerTask.taskID)")
        return getRecommendedPhotographerTask.taskID
    }
    
    /**
     * 摄影师主页——基本资料
     * method: Http.GET
     * path: /photographer/info/get
     * photographerId, long, 摄影师id
     * need test
     */
    func doGetPhotographerBaseDetailTask(photographerId: String!,
        engineProtocol: SnapShotEngineProtocol!) -> Int! {
        let getPhotographerBaseDetailTask: GetPhotographerBaseDetailTask = GetPhotographerBaseDetailTask(photographerId: photographerId, engineProtocol: engineProtocol);
        print("SnapShotTaskEngine, GetPhotographerBaseDetailTask task start, taskID = \(getPhotographerBaseDetailTask.taskID)")
        return getPhotographerBaseDetailTask.taskID
    }
    
    /**
     * 摄影师主页——作品展示（getPhotographerProduct）
     * method: Http.GET
     * path: /work/getWorks
     * photographerId, long, 摄影师id
     * page, 请求的页数
     * step, 每页的条数
     * need test
     */
    func doGetPhotographerProductTask(gid: String!, page: String!,
        step: String!, engineProtocol: SnapShotEngineProtocol!) -> Int! {
            let getPhotographerProductTask: GetPhotographerProductTask = GetPhotographerProductTask(gid: gid,
                page: page,
                step: step,
                engineProtocol: engineProtocol);
        print("SnapShotTaskEngine, GetPhotographerProductTask task start, taskID = \(getPhotographerProductTask.taskID)")
        return getPhotographerProductTask.taskID
    }
    
    /**
     * 摄影师主页——用户评论（getPhotographerComments）
     * method: Http.GET
     * path: /work/getWorks
     * userId, long, 摄影师id
     * page, 请求的页数
     * step, 每页的条数
     * need test
     */
    func doGetPhotographerCommentsTask(userId: String!, page: String!,
        step: String!, engineProtocol: SnapShotEngineProtocol!) -> Int! {
            let getPhotographerCommentsTask: GetPhotographerCommentsTask = GetPhotographerCommentsTask(userId: userId,
                page: page,
                step: step,
                engineProtocol: engineProtocol);
            print("SnapShotTaskEngine, GetPhotographerCommentsTask task start, taskID = \(getPhotographerCommentsTask.taskID)")
            return getPhotographerCommentsTask.taskID
    }
    
    /**
     * 摄影师主页——作品点赞（likeTheWork）
     * method: Http.POST
     * path: /workLike/add
     * uid：用户Id，次处必须登录
     * workId：摄影作品id
     * need test
     */
    func doLikeTheWorkTask(workId: String!, uid: String!, secretKey: String!,
        engineProtocol: SnapShotEngineProtocol!) -> Int! {
            let likeTheWorkTask: LikeTheWorkTask = LikeTheWorkTask(workId: workId,
                uid: uid,
                secretKey: secretKey,
                engineProtocol: engineProtocol);
            print("SnapShotTaskEngine, LikeTheWorkTask task start, taskID = \(likeTheWorkTask.taskID)")
            return likeTheWorkTask.taskID
    }
    
    /**
     * 摄影师主页——用户评论（commentTheWork）
     * method: Http.POST
     * path: /workLike/add
     * uid：用户Id，次处必须登录
     * workId：摄影作品id
     * content: 评论内容
     * parent: 父评论，可选
     * need test
     */
    func doCommentTheWorkTask(workId: String!, uid: String!, content: String, parent: String!, secretKey: String!,
        engineProtocol: SnapShotEngineProtocol!) -> Int! {
            let commentTheWorkTask: CommentTheWorkTask = CommentTheWorkTask(workId: workId,
                uid: uid,
                content: content,
                parent: parent,
                secretKey: secretKey,
                engineProtocol: engineProtocol);
            print("SnapShotTaskEngine, CommentTheWorkTask task start, taskID = \(commentTheWorkTask.taskID)")
            return commentTheWorkTask.taskID
    }
}
