//
//  GetPhotographerBaseDetailTask.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/21.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetPhotographerBaseDetailTask: BaseTask, HttpProtocol {
    
    var gid: String!
    
    init(photographerId: String!, engineProtocol: SnapShotEngineProtocol!) {
        super.init(taskType: TASK_TYPE_GET_PHOTOGRAPHER_BASE_DETAIL, engineProtocol: engineProtocol)
        self.gid = photographerId
        self.taskUrl = GET_PHOTOGRAPHER_BASE_DETAIL_URL
        doGetPhotographerBaseDetail()
    }
    
    func doGetPhotographerBaseDetail() {
        self.timeStamp = ToolKit.getTimeStamp()
        let parametersDic:Dictionary<String, String> = [JSON_KEY_GID: self.gid, JSON_KEY_TIME: self.timeStamp!]
        let signature = generateGetSignature(self.taskUrl, parametersDic: parametersDic)
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequest(UrlAssembler.init(taskUrl: self.taskUrl, parameterDictionary: parametersDic, signiture: signature.md5).url)
    }
    
    func didRecieveResults(results: AnyObject) {
        print("GetPhotographerBaseDetailTask, didRecieveResults")
        print("results = ")
        print(results)
        let succeed: Int = JSON(results)[JSON_KEY_SUCCEED].int!
        switch (succeed) {
        case JSON_VALUE_SUCCESS:
            let gBaseDetailModel: PhotographerBaseDetailModel = PhotographerBaseDetailModel()
            gBaseDetailModel.parseJson(JSON(results)[JSON_KEY_DATA].object)
            notifySuccess(self.taskType, successCode: TASK_RESULT_CODE_SUCCESS, extraData: gBaseDetailModel)
            break;
        case JSON_VALUE_FAILED:
            notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
            break;
        default:
            print("GetPhotographerBaseDetailTask, didRecieveResults, no matching json key")
            break;
        }
    }
    
    func didRecieveError(error: AnyObject) {
        print("GetPhotographerBaseDetailTask, didRecieveError")
        notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
    }
}