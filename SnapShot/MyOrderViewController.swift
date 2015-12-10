//
//  MyOrderViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 04/12/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class MyOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var myOrderTableView: UITableView?
    
    init(title:String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.title = "我的订单"
        self.myOrderTableView = UITableView(frame: CGRect(x: 0, y: 44, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 44), style: .Plain)
        self.myOrderTableView?.delegate = self
        self.myOrderTableView?.dataSource = self
        let nibOrderCell = UINib(nibName: "OrderCell", bundle: nil)
        self.myOrderTableView?.registerNib(nibOrderCell, forCellReuseIdentifier: "orderCell")
        self.view.addSubview(self.myOrderTableView!)
    }
    
    //==================UITableViewDataSource====================================================//
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = (self.myOrderTableView!.dequeueReusableCellWithIdentifier("orderCell", forIndexPath: indexPath) as? OrderCell)!
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //==================UITableViewDelegate===========================================================//
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return VALUE_CELL_HEIGHT
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
