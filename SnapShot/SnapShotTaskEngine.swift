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
    
    func doRegister(username: String!, phoneNum: String!, password: String!, verifyCode: String!, engineProtocol:SnapShotEngineProtocol!) -> Int! {
        let registerTask: RegisterTask = RegisterTask(username: username, phoneNum:phoneNum, password:password, verifyCode: verifyCode, engineProtocol:engineProtocol);
        return registerTask.taskType
    }
    
    func doLogin(username:String!, phoneNum:String!, password:String!, engineProtocol:SnapShotEngineProtocol!) -> Int! {
        let loginTask: LoginTask = LoginTask(username: username, phoneNum:phoneNum, password:password, engineProtocol:engineProtocol);
        return loginTask.taskType
    }
    
    func doGetVerifyCode(phoneNum: String!, engineProtocol:SnapShotEngineProtocol!) -> Int! {
        let getVerifyCodeTask: GetSMSVerifyCodeTask = GetSMSVerifyCodeTask(phoneNum: phoneNum, engineProtocol:engineProtocol);
        return getVerifyCodeTask.taskType
    }
    
}
