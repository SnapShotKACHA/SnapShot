//
//  GetUserInfoTask.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/12.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetUserInfoTask: BaseTask, HttpProtocol {
    
    var uid: String!
    
    init(userId: String!, engineProtocol: SnapShotEngineProtocol!) {
        super.init(taskType: TASK_TYPE_GET_USER_INFO, engineProtocol: engineProtocol)
        self.uid = userId
        self.taskUrl = GET_USER_INFO_URL
        doGetUserInfo()
    }
    
    func doGetUserInfo() {
        self.timeStamp = ToolKit.getTimeStamp()
        let parametersDic:Dictionary<String, String> = [JSON_KEY_UID: self.uid, JSON_KEY_TIME: self.timeStamp!]
        let signature = generateGetSignature(self.taskUrl, parametersDic: parametersDic)
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequest(UrlAssembler.init(taskUrl: self.taskUrl, parameterDictionary: parametersDic, signiture: signature.md5).url)
    }

    func didRecieveResults(results: AnyObject) {
        print("GetUserInfoTask, didRecieveResults")
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
            print("GetUserInfoTask, didRecieveResults, no matching json key")
            break;
        }
    }
    
    func didRecieveError(error: AnyObject) {
        print("GetUserInfoTask, didRecieveError")
        notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
    }
}