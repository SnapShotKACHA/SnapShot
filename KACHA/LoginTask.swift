
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
    
    override init(taskID: Int, taskUrl: String, viewController: BasicViewController?) {
        super.init(taskID: taskID, taskUrl: taskUrl, viewController:viewController)
    }
    
    func doLoginWithUserName(username:String, password:String) {
        self.username = username
        self.password = password.md5
        self.timeStamp = ToolKit.getTimeStamp()
        let signature = "POST\(self.taskUrl)time=\(self.timeStamp)username=\(self.username)\(self.password)"
        let parametersDic:Dictionary<String, String> = ["username": self.username!, "time": timeStamp!]
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequestWithParams(self.taskUrl, param: Parameters(parameterDictionary: parametersDic, signiture: signature.md5))
    }
    
    func doLoginWithPhoneNum(phoneNum:String, password:String) {
        self.phoneNum = phoneNum
        self.password = password.md5
        self.timeStamp = ToolKit.getTimeStamp()
        let signature = "POST\(self.taskUrl!)phoneNum=\(self.phoneNum!)time=\(self.timeStamp!)\(self.password!.md5)"
        let parametersDic:Dictionary<String, String> = ["phoneNum": phoneNum, "time": timeStamp!]
        self.httpControl = HttpControl(delegate: self)
        self.httpControl.onRequestWithParams(self.taskUrl, param: Parameters(parameterDictionary: parametersDic, signiture: signature.md5))
    }
    
    func didRecieveResults(results: AnyObject) {
        print(results)
        if JSON(results)["succeed"].int! == 1 {
            userDefaults.setObject(self.phoneNum, forKey: "phoneNum")
            userDefaults.setObject(self.password, forKey: "password")
            userDefaults.setObject(self.username, forKey: "username")
            isLogin = true
            self.viewController?.navigationController!.popToRootViewControllerAnimated(true)
        } else {
           
            let cancelAction = UIAlertAction(title: "重新登录", style: .Cancel, handler: nil)
            self.viewController?.presentViewController(ViewWidgest.displayAlert("登录错误", message: "请核对用户名和密码", actions: [cancelAction]), animated: true, completion: nil)
            
            didRecieveError("requestFailed")
        }
        print("httpProtocol is called")
    }
    
    func didRecieveError(error: AnyObject) {
        print("httpProtocol is called")
    }

}