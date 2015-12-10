//
//  RegisterTask.swift
//  SnapShot
//
//  Created by Jacob Li on 20/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class RegisterTask: BaseTask, HttpProtocol {
    
    var phoneNum:String?
    var username:String?
    var authCode:String?
    var password:String?
   
    override init(taskID: Int, taskUrl: String, viewController: BasicViewController?) {
        super.init(taskID: taskID, taskUrl: taskUrl, viewController:viewController)
    }
    
    func getSMSValidCode(phoneNum: String) {
        self.timeStamp = ToolKit.getTimeStamp()
        let signature = "POST\(self.taskUrl)phoneNum=\(phoneNum)time=\(self.timeStamp)\(SECRET_KEY)"
        let parametersDic:Dictionary<String, String> = ["phoneNum": phoneNum, "time": self.timeStamp!]
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequestWithParams(self.taskUrl, param: Parameters(parameterDictionary: parametersDic, signiture: signature.md5))
    }
    
    func doRegister(phoneNum: String, username: String, password: String, authCode: String) {
       
        self.phoneNum = phoneNum
        self.username = username
        self.authCode = authCode
        self.password = password.md5
        
        self.timeStamp = ToolKit.getTimeStamp()
        let signature = "POST\(self.taskUrl)authCode=\(authCode)password=\(self.password!)phoneNum=\(self.phoneNum!)time=\(timeStamp)username=\(self.username!)\(SECRET_KEY)"
        
        let parametersDic:Dictionary<String, String> = ["phoneNum": self.phoneNum!, "username": self.username!, "password": self.password!, "authCode": self.authCode!, "time": self.timeStamp!]
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequestWithParams(self.taskUrl, param: Parameters(parameterDictionary: parametersDic, signiture: signature.md5))
    }
    
    func didRecieveResults(results: AnyObject) {
        if JSON(results)["succeed"].int! == 1{
            if self.taskID == 02 {
                userDefaults.setObject(self.phoneNum, forKey: "phoneNum")
                userDefaults.setObject(self.password?.md5, forKey: "password")
                userDefaults.setObject(self.username, forKey: "username")
                isLogin = true
                self.viewController?.navigationController!.popToRootViewControllerAnimated(true)
            } else {
                print("get a")
            }
        } else {
            didRecieveError("requestFailed")
        }
        print("httpProtocol is called")
    }
    
    func didRecieveError(error: AnyObject) {
        print("httpProtocol is called")
    }
    
}