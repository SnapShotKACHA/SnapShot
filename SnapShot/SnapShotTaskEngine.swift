//
//  SnapShotTaskEngine.swift
//  SnapShot
//
//  Created by 张磊 on 15/12/10.
//  Copyright © 2015年 Jacob Li. All rights reserved.
//

import Foundation


class SnapShotTaskEngine {
    
    class func getInstance() -> SnapShotTaskEngine! {
        struct SnapShotSingleton {
            static var predicate: dispatch_once_t = 0
            static var instance: SnapShotTaskEngine? = nil
        }
        dispatch_once(&SnapShotSingleton.predicate, {SnapShotSingleton.instance = SnapShotTaskEngine()})
        return SnapShotSingleton.instance
    }
    
    class func doRegisterTask() {
        
    }
    
}
