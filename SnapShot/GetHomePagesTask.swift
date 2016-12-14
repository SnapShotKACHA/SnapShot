//
//  GetHomePagesTask.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/12.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetHomePagesTask: BaseTask, HttpProtocol {
    
    init(phoneNum: String!, engineProtocol: SnapShotEngineProtocol!) {
        super.init(taskType: TASK_TYPE_GET_HOME_PAGES, engineProtocol: engineProtocol)
        self.taskUrl = GET_HOME_PAGES_URL
        getHomePageImage()
    }
    
    func getHomePageImage() {
        let timeStamp = ToolKit.getTimeStamp()
        let sig = "GEThttp://111.13.47.169:8080/materials/homepagestime=\(timeStamp)f4a8yoxG9F6b1gUB"
        let urlAssembler = UrlAssembler(taskUrl: self.taskUrl, parameterDictionary: [JSON_KEY_TIME: timeStamp], signiture: sig.md5)
        let httpControl = HttpControl(delegate: self)
        httpControl.onRequest(urlAssembler.url)
    }
    
    func didRecieveResults(_ results: AnyObject) {
        print("GetHomePagesTask, didRecieveResults")
        print(results)
        let succeed: Int = JSON(results)[JSON_KEY_SUCCEED].int!
        if (succeed == JSON_VALUE_SUCCESS) {
            print(JSON(results)["data"][0])
            var sampleString: String = JSON(results)["data"]["items"].string!
            sampleString = sampleString.replacingOccurrences(of: "[", with: "")
            sampleString = sampleString.replacingOccurrences(of: "]", with: "")
            sampleString = sampleString.replacingOccurrences(of: "\"", with: "")
            notifySuccess(self.taskType, successCode: TASK_RESULT_CODE_SUCCESS, extraData: sampleString)
        } else {
            notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "")
            print("GetHomePagesTask, didRecieveResults, no matching json key")
        }
    }
    
    func didRecieveError(_ error: AnyObject) {
        print("GetHomePagesTask, didRecieveError")
    }
}
