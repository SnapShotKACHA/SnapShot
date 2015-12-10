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

class BaseTask:NSObject {
    var taskID: Int!
    var taskUrl: String!
    var timeStamp: String?
    var httpControl: HttpControl!
    var viewController: BasicViewController?
        
    init(taskID:Int, taskUrl: String, viewController: BasicViewController?) {
        super.init()
        self.taskID = taskID
        self.taskUrl = taskUrl
        
        if viewController != nil {
            self.viewController = viewController
        }
    }
}
