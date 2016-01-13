//
//  BaseTask.swift
//  SnapShot
//
//  Created by Jacob Li on 20/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



class BaseTask : NSObject {
    
    var taskID: Int! = PUBLIC_TASK_ID + 1
    var taskType: Int!
    var taskUrl: String!
    var timeStamp: String?
    var httpControl: HttpControl!
    var engineProtocol: SnapShotEngineProtocol!
        
    init(taskType: Int, engineProtocol:SnapShotEngineProtocol?) {
        super.init()
        PUBLIC_TASK_ID += 1
        self.taskType = taskType
        self.engineProtocol = engineProtocol
    }
    
    func notifySuccess(taskType: Int!, successCode: Int!, extraData: AnyObject!) {
        if (self.engineProtocol != nil) {
            self.engineProtocol.onTaskSuccess(taskType, successCode: successCode, extraData: extraData)
        }
}
    
    func notifyFailed(taskType: Int!, errorCode: Int!, extraData: AnyObject!) {
        if (self.engineProtocol != nil) {
            self.engineProtocol.onTaskError(taskType, errorCode: errorCode, extraData: extraData)
        }
    }
    
    func generatePostSignature(url: String!, parametersDic:Dictionary<String, String>) -> String! {
        return generateSignature("POST", url: url, parametersDic: parametersDic);
    }
    
    func generateGetSignature(url: String!, parametersDic:Dictionary<String, String>) -> String! {
        return generateSignature("GET", url: url, parametersDic: parametersDic);
    }
    
    private func generateSignature(method: String!, url: String!, parametersDic:Dictionary<String, String>) -> String! {
        var result: String = method
        result += url;
        let sortedDic = parametersDic.sort{$0.0 < $1.0}
        for (parameter, parameterValue) in sortedDic {
            result += "\(parameter)=\(parameterValue)"
        }
        result += SECRET_KEY
        print("generateSignature = ")
        print(result)
        return result;
    }


}
