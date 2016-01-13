//
//  ModifyUserNameTask.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/13.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class ModifyUserNameTask: BaseTask, HttpProtocol {
    
    var newName: String!
    var uid: String!
    
    init(newName: String!, uid: String!, engineProtocol: SnapShotEngineProtocol!) {
        super.init(taskType: TASK_TYPE_MODIFY_USER_NAME, engineProtocol: engineProtocol)
        self.newName = newName
        self.uid = uid
        self.taskUrl = MODIFY_USER_NAME_URL
        ModifyUserName()
    }
    
    func ModifyUserName() {
        self.timeStamp = ToolKit.getTimeStamp()
        let parametersDic: Dictionary<String, String> = [JSON_KEY_NEW_NAME: self.newName, JSON_KEY_UID: self.uid, JSON_KEY_TIME: self.timeStamp!]
        let signature = generatePostSignature(self.taskUrl, parametersDic: parametersDic)
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequestWithParams(self.taskUrl, param: Parameters(parameterDictionary: parametersDic, signiture: signature.md5))
    }
    
    func didRecieveResults(results: AnyObject) {
        print("ModifyUserNameTask, didRecieveResults")
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
            print("ModifyUserNameTask, didRecieveResults, no matching json key")
            break;
        }
    }
    
    func didRecieveError(error: AnyObject) {
        print("ModifyUserNameTask, didRecieveError")
        notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
    }
    
}