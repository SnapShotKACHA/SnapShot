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
     * need test
     */
    func doModifyUserNameTask(newName: String!, uid:String!, engineProtocol: SnapShotEngineProtocol!) -> Int! {
        let modifyUserNameTask: ModifyUserNameTask = ModifyUserNameTask(newName: newName, uid: uid, engineProtocol: engineProtocol);
        print("SnapShotTaskEngine, ModifyUserNameTask task start, taskID = \(modifyUserNameTask.taskID)")
        return modifyUserNameTask.taskID
    }
    
    /**
     * 修改密码
     * path: /user/password/mod
     * phoneNum, string, 手机号码
     * password, string, 用户新密码经md5加密后的字符串
     * authCode, string, 手机验证码
     * need test
     */
    func doModifyPasswordTask(phoneNum: String!, password: String!, authCode: String!, engineProtocol: SnapShotEngineProtocol!) -> Int! {
        let modifyPasswordTask: ModifyPasswordTask = ModifyPasswordTask(phoneNum: phoneNum,
            password: password,
            authCode: authCode,
            engineProtocol: engineProtocol);
        print("SnapShotTaskEngine, ModifyPasswordTask task start, taskID = \(modifyPasswordTask.taskID)")
        return modifyPasswordTask.taskID
    }
    
}
