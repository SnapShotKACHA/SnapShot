//
//  LoginModel.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/12.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginModel {
    
    var phoneNum: String?;
    var username: String?;
    var uid: String?;
    
    init() {
        phoneNum = ""
        username = ""
        uid = ""
    }
    
    func parseJson(object: AnyObject) {
        phoneNum = JSON(object)[JSON_KEY_PHONE_NUM].string
        username = JSON(object)[JSON_KEY_USER_NAME].string
        uid = JSON(object)[JSON_KEY_UID].string
    }
    
}