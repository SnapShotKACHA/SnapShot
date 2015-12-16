//
//  OrderDetailViewController.swift
//  SnapShot
//
//  Created by RANRAN on 15/12/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class OrderDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var orderDetailTableView:UITableView?
    
    override func viewDidLoad() {
        self.orderDetailTableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCROLL_HEIGHT), style: .Plain)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        } else if indexPath.section == 1 {
            return 200
        } else if indexPath.section == 2 {
            return 90
        } else if indexPath.section == 3 {
            if indexPath.row == 3 {
                return 80
            } else {
                return 40
            }
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 && section == 1 {
            return 1
        } else if section == 2 {
            return 2
        } else {
            return 5
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
}
