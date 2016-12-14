//
//  LoginModel.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/12.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginModel: BaseModel {
    
    var phoneNum: String?;
    var username: String?;
    var uid: String?;
    
    override init() {
        phoneNum = ""
        username = ""
        uid = ""
    }
    
    override func parseJson(_ object: AnyObject) {
        super.parseJson(object)
        phoneNum = JSON(object)[JSON_KEY_PHONE_NUM].string
        username = JSON(object)[JSON_KEY_USER_NAME].string
        uid = JSON(object)[JSON_KEY_UID].string
    }
    
}
