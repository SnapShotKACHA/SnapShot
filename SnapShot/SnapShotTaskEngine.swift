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
    func doRegister(username: String!, phoneNum: String!, password: String!, verifyCode: String!, engineProtocol:SnapShotEngineProtocol!) -> Int! {
        let registerTask: RegisterTask = RegisterTask(username: username, phoneNum:phoneNum, password:password, verifyCode: verifyCode, engineProtocol:engineProtocol);
        print("SnapShotTaskEngine, register task start, taskID = \(registerTask.taskID)")
        return registerTask.taskID
    }
    
    /*
     * 登录成功后，SnapShotEngineProtocol中onTaskSuccess方法，返回LoginModel
     * 可根据uid查找用户信息
     */
    func doLogin(username:String!, phoneNum:String!, password:String!, engineProtocol:SnapShotEngineProtocol!) -> Int! {
        let loginTask: LoginTask = LoginTask(username: username, phoneNum:phoneNum, password:password, engineProtocol:engineProtocol);
        print("SnapShotTaskEngine, login task start, taskID = \(loginTask.taskID)")
        return loginTask.taskID
    }
    
    func doGetVerifyCode(phoneNum: String!, engineProtocol:SnapShotEngineProtocol!) -> Int! {
        let getVerifyCodeTask: GetSMSVerifyCodeTask = GetSMSVerifyCodeTask(phoneNum: phoneNum, engineProtocol:engineProtocol);
        print("SnapShotTaskEngine, GetVerifyCode task start, taskID = \(getVerifyCodeTask.taskID)")
        return getVerifyCodeTask.taskID
    }
    
    func doGetUserInfoTask(userId: String!, engineProtocol: SnapShotEngineProtocol!) -> Int! {
        let getUserInfoTask: GetUserInfoTask = GetUserInfoTask(userId: userId, engineProtocol: engineProtocol);
        print("SnapShotTaskEngine, getUserInfoTask task start, taskID = \(getUserInfoTask.taskID)")
        return getUserInfoTask.taskID
    }
    
}
