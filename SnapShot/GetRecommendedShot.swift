//
//  GetRecommendedShot.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/14.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

/*
    用于获取首页推荐特色服务的banner信息，HTTP.GET
*/
class GetRecommendedShotTask: BaseTask, HttpProtocol {
    
    var uid: String!
    var longitude: String!
    var latitude: String!
    
    init(userId: String!, longitude: String!, latitude: String!, engineProtocol: SnapShotEngineProtocol!) {
        super.init(taskType: TASK_TYPE_GET_RECOMMENDED_SHOT, engineProtocol: engineProtocol)
        self.uid = userId
        self.longitude = longitude
        self.latitude = latitude
        self.taskUrl = GET_RECOMMENDED_SHOT_URL
        getRecommendedShot()
    }
    
    func getRecommendedShot() {
        self.timeStamp = ToolKit.getTimeStamp()
        let parametersDic:Dictionary<String, String> = [JSON_KEY_UID: self.uid,
            JSON_KEY_LONGITUDE: self.longitude,
            JSON_KEY_LATITUDE: self.latitude,
            JSON_KEY_TIME: self.timeStamp!]
        let signature = generateGetSignature(self.taskUrl, parametersDic: parametersDic)
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequest(UrlAssembler.init(taskUrl: self.taskUrl, parameterDictionary: parametersDic, signiture: signature.md5).url)
    }
    
    func didRecieveResults(results: AnyObject) {
        print("GetRecommendedShotTask, didRecieveResults")
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
            print("GetRecommendedShotTask, didRecieveResults, no matching json key")
            break;
        }
    }
    
    func didRecieveError(error: AnyObject) {
        print("GetRecommendedShotTask, didRecieveError")
        notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
    }
}