//
//  GroupViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 11/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var groupTableView: UITableView!
    var navBtn: UIButton?
    var priceSortButton: UIButton?
    var distanceSortButton: UIButton?
    var dateSortButton: UIButton?
    
    
    override func viewWillAppear(animated: Bool) {
        if self.navBtn == nil {
            self.navBtn = ViewWidgest.addLeftButton("navigationButtonImage", imageAfter: "navigationButtonImage")
            self.navBtn?.addTarget(self, action: "popToRoot", forControlEvents: UIControlEvents.TouchUpInside)
        }
        self.navigationController?.navigationBar.addSubview(self.navBtn!)
        groupTableView.registerNib(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: "groupCell")
        groupTableView.delegate = self
        groupTableView.dataSource = self
        
        self.priceSortButton = UIButton()
        self.distanceSortButton = UIButton()
        self.dateSortButton = UIButton()
        ViewWidgest.navigatiobBarButtomButton([self.priceSortButton!,self.distanceSortButton!,self.dateSortButton!], titleArray: ["价格优先","距离优先","日期优先"], targetArrary: ["priceSortAction" , "distanceSortAction", "dateSortAction"], view: self.view)
    }
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        self.title = "一起团拍"
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        ViewWidgest.recoverNavigationBar([self.navBtn!, self.priceSortButton!,self.distanceSortButton!,self.dateSortButton!], navigationController: self.navigationController!)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var groupCell: GroupCell?
        groupCell = groupTableView.dequeueReusableCellWithIdentifier("groupCell") as? GroupCell
        groupCell?.groupCellTitleLabel.text = "奥林匹克森林公园"
        groupCell?.groupCellTimeLabel.text = "2015年11月6日14:00-18:00"
        groupCell?.groupCellLocationLabel.text = "北京奥林匹克森林公园"
        groupCell?.groupCellServiceLabel.text = ">60张拍摄，30张精修"
        groupCell?.groupCellMemberNumLabel.text = "3-5个家庭"
        groupCell?.groupCellPhotographerLabel.text = "2"
        return groupCell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let groupDetailViewController:GroupDetailViewController = GroupDetailViewController(title: "奥森萌娃外拍")
        self.navigationController?.pushViewController(groupDetailViewController, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    //==================================Button Actions========================//
    func priceSortAction() {
        
    }
    
    func distanceSortACtion() {
    
    }
    
    func dateSortAction() {
    
    }
    
    func popToRoot() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}