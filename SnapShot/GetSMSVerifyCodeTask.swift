//
//  GetSMSVerifyCodeTask.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/12.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetSMSVerifyCodeTask: BaseTask, HttpProtocol {
    
    var phoneNum: String!
    var secretKey: String!
    
    init(phoneNum: String!, engineProtocol: SnapShotEngineProtocol!) {
        super.init(taskType: TASK_TYPE_REGISTER, engineProtocol: engineProtocol)
        self.phoneNum = phoneNum
        self.taskUrl = GET_SMS_VERIFY_CODE_URL
        getSMSValidCode()
    }
    
    func getSMSValidCode() {
        self.timeStamp = ToolKit.getTimeStamp()
        let parametersDic: Dictionary<String, String> = [JSON_KEY_PHONE_NUM: phoneNum, JSON_KEY_TIME: self.timeStamp!]
        let signature = generatePostSignature(self.taskUrl, parametersDic: parametersDic, secretKey: SECRET_KEY)
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequestWithParams(self.taskUrl, param: Parameters(parameterDictionary: parametersDic, signiture: signature.md5))
    }
    
    func didRecieveResults(results: AnyObject) {
        print("GetSMSVerifyCodeTask, didRecieveResults")
        print("results = ")
        print(results)
        let succeed: Int = JSON(results)[JSON_KEY_SUCCEED].int!
        switch (succeed) {
            case JSON_VALUE_SUCCESS:
                userDefaults.setObject(self.phoneNum, forKey: JSON_KEY_PHONE_NUM)
                notifySuccess(self.taskType, successCode: TASK_RESULT_CODE_SUCCESS, extraData: "")
                break;
            case JSON_VALUE_FAILED:
                notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
                break;
            default:
                print("GetSMSVerifyCodeTask, didRecieveResults, no matching json key")
                break;
        }
    }
    
    func didRecieveError(error: AnyObject) {
        print("GetSMSVerifyCodeTask, didRecieveError")
        notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
    }

}