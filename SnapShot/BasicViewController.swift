//
//  BasicViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 09/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class BasicViewController: UIViewController, SnapShotEngineProtocol {
    
    override func viewDidLoad() {
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func onTaskError(taskType: Int!, errorCode: Int, extraData: AnyObject) {
        print(extraData)
    }
    
    func onTaskSuccess(taskType: Int!, successCode: Int, extraData: AnyObject) {
        print(extraData)
    }
}
