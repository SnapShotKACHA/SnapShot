//
//  CommentTheWorkTask.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/25.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class CommentTheWorkTask: BaseTask, HttpProtocol {
    
    var workId: String!
    var uid: String!
    var content: String!
    var parent: String! // 父id，可选
    var secretKey: String!
    
    init(workId: String!, uid: String!, content: String, parent: String!, secretKey: String!, engineProtocol: SnapShotEngineProtocol!) {
        super.init(taskType: TASK_TYPE_COMMENT_THE_WORK, engineProtocol: engineProtocol)
        self.workId = workId
        self.uid = uid
        self.parent = parent
        self.content = content
        self.secretKey = secretKey
        self.taskUrl = COMMENT_THE_WORK_URL
        commentThisWork()
    }
    
    func commentThisWork() {
        self.timeStamp = ToolKit.getTimeStamp()
        let parametersDic: Dictionary<String, String> = [JSON_KEY_WORD_ID: self.workId,
            JSON_KEY_UID: self.uid,
            JSON_KEY_CONTENT: self.content,
            JSON_KEY_PARENT: self.parent,
            JSON_KEY_TIME: self.timeStamp!]
        let signature = generatePostSignature(self.taskUrl, parametersDic: parametersDic, secretKey: self.secretKey)
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequestWithParams(self.taskUrl, param: Parameters(parameterDictionary: parametersDic, signiture: signature.md5))
    }
    
    func didRecieveResults(results: AnyObject) {
        print("CommentTheWorkTask, didRecieveResults")
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
            print("CommentTheWorkTask, didRecieveResults, no matching json key")
            break;
        }
    }
    
    func didRecieveError(error: AnyObject) {
        print("CommentTheWorkTask, didRecieveError")
        notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
    }
    
}