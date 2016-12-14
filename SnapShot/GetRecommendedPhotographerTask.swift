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
    用于获取首页推荐摄影师的信息，HTTP.GET
*/
class GetRecommendedPhotographerTask: BaseTask, HttpProtocol {
    
    var uid: String!
    var longitude: String!
    var latitude: String!
    var page: String!
    var step: String!
    
    init(uid: String!,
        longitude: String!,
        latitude: String!,
        page: String!,
        step: String!,
        engineProtocol: SnapShotEngineProtocol!) {
        super.init(taskType: TASK_TYPE_GET_RECOMMENDED_PHOTOGRAPHER, engineProtocol: engineProtocol)
        self.uid = uid
        self.longitude = longitude
        self.latitude = latitude
        self.page = page
        self.step = step
        self.taskUrl = GET_RECOMMENDED_PHOTOGRAPHER_URL 
        getRecommendedShot()
    }
    
    func getRecommendedShot() {
        self.timeStamp = ToolKit.getTimeStamp()
        let parametersDic:Dictionary<String, String> = [JSON_KEY_UID: self.uid,
            JSON_KEY_LONGITUDE: self.longitude,
            JSON_KEY_LATITUDE: self.latitude,
            JSON_KEY_PAGE: self.page,
            JSON_KEY_STEP: self.step,
            JSON_KEY_TIME: self.timeStamp!]
        let signature = generateGetSignature(self.taskUrl, parametersDic: parametersDic)
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequest(UrlAssembler.init(taskUrl: self.taskUrl, parameterDictionary: parametersDic, signiture: signature.md5).url)
    }
    
    func didRecieveResults(_ results: AnyObject) {
        print("GetRecommendedPhotographerTask, didRecieveResults")
        print("results = ")
        print(results)
        let succeed: Int = JSON(results)[JSON_KEY_SUCCEED].int!
        switch (succeed) {
        case JSON_VALUE_SUCCESS:
            // 学习如何回传list
            JSON(results)[JSON_KEY_DATA]
//            let photographerIntroduceModel: PhotographerIntroduceModel = PhotographerIntroduceModel();
//            photographerIntroduceModel.parseJson("")
            notifySuccess(self.taskType, successCode: TASK_RESULT_CODE_SUCCESS, extraData: results)
            break;
        case JSON_VALUE_FAILED:
            notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
            break;
        default:
            print("GetRecommendedPhotographerTask, didRecieveResults, no matching json key")
            break;
        }
    }
    
    func didRecieveError(_ error: AnyObject) {
        print("GetRecommendedPhotographerTask, didRecieveError")
        notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
    }
}
