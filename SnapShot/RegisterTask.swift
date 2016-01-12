//
//  RegisterTask.swift
//  SnapShot
//
//  Created by Jacob Li on 20/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class RegisterTask: BaseTask, HttpProtocol {
    
    var phoneNum:String?
    var username:String?
    var authCode:String?
    var password:String?
   
    init(username:String!, phoneNum: String!, password: String!, verifyCode: String!, engineProtocol: SnapShotEngineProtocol!) {
        super.init(taskType: TASK_TYPE_REGISTER, engineProtocol: engineProtocol)
        self.password = password
        self.username = username
        self.phoneNum = phoneNum
        self.authCode = verifyCode
        self.taskUrl = REGISTER_URL
        doRegister()
    }
        
    func doRegister() {
        self.password = self.password!.md5
        self.timeStamp = ToolKit.getTimeStamp()
        let signature = "POST\(self.taskUrl)authCode=\(authCode)password=\(self.password!)phoneNum=\(self.phoneNum!)time=\(timeStamp)username=\(self.username!)\(SECRET_KEY)"
        let parametersDic:Dictionary<String, String> = [JSON_KEY_PHONE_NUM: self.phoneNum!,
            JSON_KEY_USER_NAME: self.username!,
            JSON_KEY_PASSWORD: self.password!,
            JSON_KEY_AUTH_CODE: self.authCode!,
            JSON_KEY_TIME: self.timeStamp!]
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequestWithParams(self.taskUrl, param: Parameters(parameterDictionary: parametersDic, signiture: signature.md5))
    }
    
    func didRecieveResults(results: AnyObject) {
        print("RegisterTask, didRecieveResults")
        print(results)
        let succeed: Int = JSON(results)[JSON_KEY_SUCCEED].int!
        if (succeed == JSON_VALUE_SUCCESS) {
            userDefaults.setObject(self.phoneNum, forKey: JSON_KEY_PHONE_NUM)
            userDefaults.setObject(self.password?.md5, forKey: JSON_KEY_PASSWORD)
            userDefaults.setObject(self.username, forKey: JSON_KEY_USER_NAME)
            isLogin = true
            notifySuccess(self.taskType, successCode: TASK_RESULT_CODE_SUCCESS, extraData: "")
        } else if (JSON_VALUE_FAILED == succeed) {
            notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "") // custom error code
        } else {
            print("RegisterTask, didRecieveResults, no matching json key")
            notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
        }
   
    }
    
    func didRecieveError(error: AnyObject) {
        print("RegisterTask, didRecieveError")
        notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
    }
    
}