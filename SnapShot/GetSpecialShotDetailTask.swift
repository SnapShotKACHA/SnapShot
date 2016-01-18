//
//  GetSpecialShotDetail.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/14.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

/*
    用于获取特色服务详情，HTTP.GET
*/
class GetSpecialShotDetailTask: BaseTask, HttpProtocol {
    
    var shotId: String!
    
    init(shotId: String!, engineProtocol: SnapShotEngineProtocol!) {
        super.init(taskType: TASK_TYPE_GET_SPECIAL_SHOT_DETAIL, engineProtocol: engineProtocol)
        self.shotId = shotId
        self.taskUrl = GET_SPECIAL_SHOT_DETAIL_URL
        getSpecialShotDetail()
    }
    
    func getSpecialShotDetail() {
        self.timeStamp = ToolKit.getTimeStamp()
        let parametersDic:Dictionary<String, String> = [JSON_KEY_SHOT_ID: self.shotId,
            JSON_KEY_TIME: self.timeStamp!]
        let signature = generateGetSignature(self.taskUrl, parametersDic: parametersDic)
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequest(UrlAssembler.init(taskUrl: self.taskUrl, parameterDictionary: parametersDic, signiture: signature.md5).url)
    }
    
    func didRecieveResults(results: AnyObject) {
        print("GetSpecialShotDetailTask, didRecieveResults")
        print("results = ")
        print(results)
        let succeed: Int = JSON(results)[JSON_KEY_SUCCEED].int!
        switch (succeed) {
        case JSON_VALUE_SUCCESS:
            let specailShotModel: SpecialShotDetailModel = SpecialShotDetailModel.init();
            specailShotModel.parseJson(JSON(results)[JSON_KEY_DATA].object)
            notifySuccess(self.taskType, successCode: TASK_RESULT_CODE_SUCCESS, extraData: specailShotModel)
            break;
        case JSON_VALUE_FAILED:
            notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
            break;
        default:
            print("GetSpecialShotDetailTask, didRecieveResults, no matching json key")
            break;
        }
    }
    
    func didRecieveError(error: AnyObject) {
        print("GetSpecialShotDetailTask, didRecieveError")
        notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
    }
}