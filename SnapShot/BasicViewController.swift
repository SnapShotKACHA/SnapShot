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
        self.navigationController!.navigationBar.tintColor = UIColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func onTaskError(_ taskType: Int!, errorCode: Int, extraData: AnyObject) {
        print(extraData)
    }
    
    func onTaskSuccess(_ taskType: Int!, successCode: Int, extraData: AnyObject) {
        print(extraData)
    }
}
