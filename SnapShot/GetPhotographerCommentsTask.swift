//
//  GetPhotographerCommentsTask.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/21.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetPhotographerCommentsTask: BaseTask, HttpProtocol {
    
    fileprivate var uid: String!
    fileprivate var page: String!
    fileprivate var step: String!
    
    init(userId: String!, page: String!, step: String!, engineProtocol: SnapShotEngineProtocol!) {
        super.init(taskType: TASK_TYPE_GET_PHOTOGRAPHER_COMMENT, engineProtocol: engineProtocol)
        self.uid = userId
        self.page = page
        self.step = step
        self.taskUrl = GET_PHOTOGRAPHER_COMMENT_URL
        doGetPhotographerComments()
    }
    
    func doGetPhotographerComments() {
        self.timeStamp = ToolKit.getTimeStamp()
        let parametersDic:Dictionary<String, String> = [JSON_KEY_UID: self.uid,
            JSON_KEY_PAGE: self.page,
            JSON_KEY_STEP: self.step,
            JSON_KEY_TIME: self.timeStamp!]
        let signature = generateGetSignature(self.taskUrl, parametersDic: parametersDic)
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequest(UrlAssembler.init(taskUrl: self.taskUrl, parameterDictionary: parametersDic, signiture: signature.md5).url)
    }
    
    func didRecieveResults(_ results: AnyObject) {
        print("GetPhotographerCommentsTask, didRecieveResults")
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
            print("GetPhotographerCommentsTask, didRecieveResults, no matching json key")
            break;
        }
    }
    
    func didRecieveError(_ error: AnyObject) {
        print("GetPhotographerCommentsTask, didRecieveError")
        notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
    }
}
