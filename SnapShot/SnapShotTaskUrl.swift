//
//  SnapShotTaskUrl.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/14.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation

// 网络参数
let ROOT_URL = "http://111.13.47.169:8080"
let GET_SMS_VERIFY_CODE_URL = ROOT_URL + "/sms/authCode/send"
let GET_HOME_PAGES_URL = ROOT_URL + "/materials/homepages"
let REGISTER_URL = ROOT_URL + "/user/register"
let LOGIN_URL = ROOT_URL + "/user/login"
let SECRET_KEY = "f4a8yoxG9F6b1gUB"
let GET_USER_INFO_URL = ROOT_URL + "/user/info/get"
let MODIFY_USER_NAME_URL = ROOT_URL + "/user/name/mod"
let MODIFY_PASSWORD_URL = ROOT_URL + "/user/password/mod"
let ENROLL_GROUP_SHOT_URL = ROOT_URL + "/groupShot/enroll"
let GET_RECOMMENDED_SPECIAL_SHOT_URL = ROOT_URL + "/home/recommendedSpecialShot"
let GET_SPECIAL_SHOT_DETAIL_URL = ROOT_URL + "/specialShot/detail"
let GET_RECOMMENDED_PHOTOGRAPHER_URL = ROOT_URL + "/home/recommendedShots"
let GET_PHOTOGRAPHER_BASE_DETAIL_URL = ROOT_URL + "/photographer/info/get"
let GET_PHOTOGRAPHER_PRODUCT_URL = ROOT_URL + "/work/getWorks"
let GET_PHOTOGRAPHER_COMMENT_URL = ROOT_URL + "/userComment/getAboutUser"
let LIKE_THE_WORK_URL = ROOT_URL + "/workLike/add"
let COMMENT_THE_WORK_URL = ROOT_URL + "/workComment/add"
let GET_SEPCIAL_SHOT_LIST_URL = ROOT_URL + "/specialShot/get"