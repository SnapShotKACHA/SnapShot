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
    var startServiceButton: UIButton = UIButton(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 60, width: SCREEN_WIDTH, height: 60))
    
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
        ViewWidgest.navigatiobBarButtomButton([self.priceSortButton!,self.distanceSortButton!,self.dateSortButton!], titleArray: ["价格优先","距离优先","日期优先"], targetArrary: ["priceSortAction" , "distanceSortAction", "dateSortAction"], viewController: self, yPosition: 64)
        
        self.startServiceButton.backgroundColor = SP_BLUE_COLOR
        self.startServiceButton.tintColor = UIColor.whiteColor()
        self.startServiceButton.setTitle("发起活动", forState: .Normal)
        self.startServiceButton.titleLabel?.font = UIFont(name: HEITI, size: 17)
        self.startServiceButton.layer.borderWidth = 12
        self.startServiceButton.layer.borderColor = BACKGROUND_COLOR_GREY.CGColor
        self.view.addSubview(self.startServiceButton)
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
        if indexPath.section == 0{
            
            groupCell?.groupCellTitleLabel.text = "奥林匹克森林公园"
            groupCell?.groupCellTimeLabel.text = "2015年11月6日14:00-18:00"
            groupCell?.groupCellLocationLabel.text = "北京奥林匹克森林公园"
            groupCell?.groupCellServiceLabel.text = ">60张拍摄，30张精修"
            groupCell?.groupCellMemberNumLabel.text = "3-5个家庭"
            groupCell?.groupCellPhotographerLabel.text = "2"
        } else {
            groupCell?.groupCellTitleLabel.text = "朝阳公园孕妇周记"
            groupCell?.groupCellTimeLabel.text = "2015年11月6日14:00-18:00"
            groupCell?.groupCellLocationLabel.text = "北京朝阳公园"
            groupCell?.groupCellServiceLabel.text = ">50张拍摄，15张精修"
            groupCell?.groupCellMemberNumLabel.text = "2-3位孕妈妈"
            groupCell?.groupCellPhotographerLabel.text = "1"
        }
        
        
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
        return 2
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