//
//  Constant.swift
//  SnapShot
//
//  Created by Jacob Li on 14/10/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

// Universe Varible
var isLogin = false
var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()

//主页上得各种高度的变量
let TABLE_CELL_HEIGHT : Float = 100
let SECTION_HEIGHT:Float = 24
let SCROLL_HEIGHT:Float = 80
let IMAGE_HEIGHT:Float = 400
let IN_WINDOW_HEIGHT:Float = 250
let TITLE_HEIGHT:Float = 44
let PROFILE_CELL_HEIGHT: Float = 120
let VALUE_CELL_HEIGHT: CGFloat = 140
let CATA_CELL_HEIGHT: CGFloat = 200
let CATA_DETAIL_CELL_HEIGHT: CGFloat = 100
let FRONT_CELL_HEIGHT: CGFloat = 305
let DETAIL_CELL_HEIGHT: CGFloat = CGFloat((UIScreen.mainScreen().bounds.height - 20)/2)
let SCREEN_WIDTH:CGFloat = UIScreen.mainScreen().bounds.width
let SCREEN_HEIGHT:CGFloat = UIScreen.mainScreen().bounds.height

//字体颜色
let TEXT_COLOR_GREY:UIColor = UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 1)
let TEXT_COLOR_LIGHT_GREY:UIColor = UIColor(red: 208/255, green: 208/255, blue: 208/255, alpha: 1)
let NAVIGATION_BAR_COLOR_GREY:UIColor = UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 1)
let SP_BLUE_COLOR:UIColor = UIColor(red: 0/255, green: 85/255, blue: 170/255, alpha: 1)

//网络参数
let ROOT_URL = "http://111.13.47.169:8080"
let AUTHENTICATION_CODE_URL = ROOT_URL + "/sms/authCode/send"
let REGISTER_URL = ROOT_URL + "/user/register"
let LOGIN_URL = ROOT_URL + "/user/login"
let SECRET_KEY = "f4a8yoxG9F6b1gUB"
 