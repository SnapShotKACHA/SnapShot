//
//  SnapShotEngineProtocol.swift
//  SnapShot
//
//  Created by 张磊 on 16/1/11.
//  Copyright © 2016年 Jacob Li. All rights reserved.
//

import Foundation

protocol SnapShotEngineProtocol {
    func onTaskSuccess(_ taskType:Int!, successCode:Int, extraData:AnyObject)
    func onTaskError(_ taskType:Int!, errorCode:Int, extraData:AnyObject)
}
