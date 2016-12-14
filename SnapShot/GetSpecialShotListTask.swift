//
//  GetSpecialShotListTask.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/25.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

/*
    用于获取特色服务的列表，HTTP.GET
*/
class GetSpecialShotListTask: BaseTask, HttpProtocol {
    
    private var uid: String!
    private var longitude: String!
    private var latitude: String!
    private var page: String!
    private var step: String!

    
    init(uid: String!, longitude: String!, latitude: String!, page: String!, step: String!, engineProtocol: SnapShotEngineProtocol!) {
        super.init(taskType: TASK_TYPE_GET_SPECIAL_SHOT_LIST, engineProtocol: engineProtocol)
        self.uid = uid
        self.longitude = longitude
        self.latitude = latitude
        self.page = page
        self.step = step
        self.taskUrl = GET_SEPCIAL_SHOT_LIST_URL
        getRecommendedPhotographer()
    }
    
    func getRecommendedPhotographer() {
        self.timeStamp = ToolKit.getTimeStamp()
        let parametersDic: Dictionary<String, String> = [JSON_KEY_UID: self.uid,
            JSON_KEY_LONGITUDE: self.longitude,
            JSON_KEY_LATITUDE: self.latitude,
            JSON_KEY_STEP: self.step,
            JSON_KEY_PAGE: self.page,
            JSON_KEY_TIME: self.timeStamp!]
        let signature = generateGetSignature(self.taskUrl, parametersDic: parametersDic)
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequest(UrlAssembler.init(taskUrl: self.taskUrl, parameterDictionary: parametersDic, signiture: signature.md5).url)
    }
    
    func didRecieveResults(results: AnyObject) {
        print("GetSpecialShotListTask, didRecieveResults")
        print("results = ")
        print(results)
        let succeed: Int = JSON(results)[JSON_KEY_SUCCEED].int!
        switch (succeed) {
        case JSON_VALUE_SUCCESS:
            
            notifySuccess(self.taskType, successCode: TASK_RESULT_CODE_SUCCESS, extraData: results)
            break;
        case JSON_VALUE_FAILED:
            notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
            break;
        default:
            print("GetSpecialShotListTask, didRecieveResults, no matching json key")
            break;
        }
    }
    
    func didRecieveError(error: AnyObject) {
        print("GetSpecialShotListTask, didRecieveError")
        notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
    }
}