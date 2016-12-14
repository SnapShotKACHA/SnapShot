//
//  EnrollGroupShot.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/13.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class EnrollGroupShotTask: BaseTask, HttpProtocol {
    
    var shotId: String!
    var uid: String!
    var secretKey: String!
    
    init(shotId: String!, uid: String!, secretKey: String!, engineProtocol: SnapShotEngineProtocol!) {
        super.init(taskType: TASK_TYPE_ENROLL_GROUP_SHOT, engineProtocol: engineProtocol)
        self.shotId = shotId
        self.uid = uid
        self.secretKey = secretKey
        self.taskUrl = ENROLL_GROUP_SHOT_URL
        EnrollGroupShot()
    }
    
    func EnrollGroupShot() {
        self.timeStamp = ToolKit.getTimeStamp()
        let parametersDic: Dictionary<String, String> = [JSON_KEY_SHOT_ID: self.shotId, JSON_KEY_UID: self.uid, JSON_KEY_TIME: self.timeStamp!]
        let signature = generatePostSignature(self.taskUrl, parametersDic: parametersDic, secretKey: self.secretKey)
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequestWithParams(self.taskUrl, param: Parameters(parameterDictionary: parametersDic, signiture: signature.md5))
    }
    
    func didRecieveResults(_ results: AnyObject) {
        print("EnrollGroupShot, didRecieveResults")
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
            print("EnrollGroupShot, didRecieveResults, no matching json key")
            break;
        }
    }
    
    func didRecieveError(_ error: AnyObject) {
        print("EnrollGroupShot, didRecieveError")
        notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
    }
    
}
