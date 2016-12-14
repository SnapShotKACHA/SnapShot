//
//  ModifyPasswordTask.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/13.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class ModifyPasswordTask: BaseTask, HttpProtocol {
    
    var phoneNum: String!
    var password: String!
    var authCode: String!
    var secretKey: String!
    
    init(phoneNum: String!, password: String!, authCode: String!, secretKey: String!, engineProtocol: SnapShotEngineProtocol!) {
        super.init(taskType: TASK_TYPE_MODIFY_PASSWORD, engineProtocol: engineProtocol)
        self.phoneNum = phoneNum
        self.password = password
        self.authCode = authCode
        self.secretKey = secretKey
        self.taskUrl = MODIFY_PASSWORD_URL
        modifyPassword()
    }
    
    func modifyPassword() {
        self.timeStamp = ToolKit.getTimeStamp()
        let parametersDic: Dictionary<String, String> = [JSON_KEY_PASSWORD: self.password,
            JSON_KEY_AUTH_CODE: self.authCode,
            JSON_KEY_PHONE_NUM: self.phoneNum,
            JSON_KEY_TIME: self.timeStamp!]
        let signature = generatePostSignature(self.taskUrl, parametersDic: parametersDic, secretKey: self.secretKey)
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequestWithParams(self.taskUrl,
            param: Parameters(parameterDictionary: parametersDic, signiture: signature.md5))
    }
    
    func didRecieveResults(_ results: AnyObject) {
        print("ModifyPasswordTask, didRecieveResults")
        print("results = ")
        print(results)
        let succeed: Int = JSON(results)[JSON_KEY_SUCCEED].int!
        switch (succeed) {
        case JSON_VALUE_SUCCESS:
            notifySuccess(self.taskType, successCode: TASK_RESULT_CODE_SUCCESS, extraData: "")
            break;
        case JSON_VALUE_FAILED:
            notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
            break;
        default:
            print("ModifyPasswordTask, didRecieveResults, no matching json key")
            break;
        }
    }
    
    func didRecieveError(_ error: AnyObject) {
        print("ModifyPasswordTask, didRecieveError")
        notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
    }
    
}
