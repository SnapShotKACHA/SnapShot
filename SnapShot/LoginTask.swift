
//
//  LoginTask.swift
//  SnapShot
//
//  Created by Jacob Li on 23/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginTask: BaseTask, HttpProtocol {
    
    var username: String?
    var phoneNum: String?
    var password: String?
    
    init(username:String?, phoneNum: String?, password: String!, engineProtocol: SnapShotEngineProtocol) {
        super.init(taskType: TASK_TYPE_LOGIN, engineProtocol: engineProtocol);
        self.username = username;
        self.phoneNum = phoneNum;
        self.password = password;
        self.taskUrl = LOGIN_URL
        doLoginWithPhoneNum()
    }
    
    func doLoginWithUserName() {
        self.password = self.password!.md5
        self.timeStamp = ToolKit.getTimeStamp()
        let signature = "POST\(self.taskUrl)time=\(self.timeStamp)username=\(self.username)\(self.password)"
        let parametersDic:Dictionary<String, String> = ["username": self.username!, "time": timeStamp!]
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequestWithParams(self.taskUrl, param: Parameters(parameterDictionary: parametersDic, signiture: signature.md5))
    }
    
    func doLoginWithPhoneNum() {
        self.password = self.password!.md5
        self.timeStamp = ToolKit.getTimeStamp()
        let signature = "POST\(self.taskUrl!)phoneNum=\(self.phoneNum!)time=\(self.timeStamp!)\(self.password!.md5)"
        let parametersDic:Dictionary<String, String> = [JSON_KEY_PHONE_NUM: self.phoneNum!,
            JSON_KEY_TIME: self.timeStamp!]
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequestWithParams(self.taskUrl, param: Parameters(parameterDictionary: parametersDic, signiture: signature.md5))
    }
    
    func didRecieveResults(results: AnyObject) {
        print("LoginTask")
        print(results)
        if (JSON(results)[JSON_KEY_SUCCEED].int! == JSON_VALUE_SUCCESS) {
            let loginModel: LoginModel = LoginModel()
            loginModel.parseJson(JSON(results)[JSON_KEY_DATA].object)
            isLogin = true
            userDefaults.setObject(loginModel.phoneNum, forKey: JSON_KEY_PHONE_NUM)
            userDefaults.setObject(self.password, forKey: JSON_KEY_PASSWORD)
            userDefaults.setObject(loginModel.username, forKey: JSON_KEY_USER_NAME)
            userDefaults.setObject(loginModel.uid, forKey: JSON_KEY_UID)
            notifySuccess(self.taskType, successCode: TASK_RESULT_CODE_SUCCESS, extraData: loginModel);
        } else {
            print("LoginTask, didRecieveResults, no matching json key")
            notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "");
        }
    }
    
    func didRecieveError(error: AnyObject) {
        print("LoginTask")
        print("httpProtocol is called, didRecieveError")
        notifyFailed(self.taskType, errorCode: TASK_RESULT_CODE_GENERAL_ERROR, extraData: "");
    }  

}