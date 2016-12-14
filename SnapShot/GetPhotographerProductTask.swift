//
//  GetPhotographerProductTask.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/21.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetPhotographerProductTask: BaseTask, HttpProtocol {
    
    var gid: String!
    var page: String!
    var step: String!
    
    init(gid: String!, page: String!, step: String!, engineProtocol: SnapShotEngineProtocol!) {
        super.init(taskType: TASK_TYPE_GET_PHOTOGRAPHER_PRODUCT, engineProtocol: engineProtocol)
        self.gid = gid
        self.page = page
        self.step = step
        self.taskUrl = GET_PHOTOGRAPHER_PRODUCT_URL
        doGetPhotographerProduct()
    }
    
    func doGetPhotographerProduct() {
        self.timeStamp = ToolKit.getTimeStamp()
        let parametersDic:Dictionary<String, String> = [JSON_KEY_GID: self.gid,
            JSON_KEY_PAGE: self.page,
            JSON_KEY_STEP: self.step,
            JSON_KEY_TIME: self.timeStamp!]
        let signature = generateGetSignature(self.taskUrl, parametersDic: parametersDic)
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequest(UrlAssembler.init(taskUrl: self.taskUrl, parameterDictionary: parametersDic, signiture: signature.md5).url)
    }
    
    func didRecieveResults(_ results: AnyObject) {
        print("GetPhotographerProductTask, didRecieveResults")
        print("results = ")
        print(results)
        let succeed: Int = JSON(results)[JSON_KEY_SUCCEED].int!
        switch (succeed) {
        case JSON_VALUE_SUCCESS:
            let photographerProductModel: PhotographerProductModel = PhotographerProductModel();
            photographerProductModel.parseJson(JSON(results)[JSON_KEY_DATA].object)
            notifySuccess(self.taskType, successCode: TASK_RESULT_CODE_SUCCESS, extraData: photographerProductModel)
            break;
        case JSON_VALUE_FAILED:
            notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
            break;
        default:
            print("GetPhotographerProductTask, didRecieveResults, no matching json key")
            break;
        }
    }
    
    func didRecieveError(_ error: AnyObject) {
        print("GetPhotographerProductTask, didRecieveError")
        notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
    }
}
