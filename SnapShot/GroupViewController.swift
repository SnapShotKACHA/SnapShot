//
//  GroupViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 11/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class GroupViewController: BasicViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var groupTableView: UITableView!
    var navBtn: UIButton?
    var priceSortButton: UIButton?
    var distanceSortButton: UIButton?
    var dateSortButton: UIButton?
    var startServiceButton: UIButton = UIButton(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 60, width: SCREEN_WIDTH, height: 60))
    
    override func viewWillAppear(_ animated: Bool) {
        if self.navBtn == nil {
            self.navBtn = ViewWidgest.addLeftButton("navigationButtonImage", imageAfter: "navigationButtonImage")
            self.navBtn?.addTarget(self, action: #selector(GroupViewController.popToRoot), for: UIControlEvents.touchUpInside)
        }
        self.navigationController?.navigationBar.addSubview(self.navBtn!)
        groupTableView.register(UINib(nibName: "GroupCell", bundle: nil), forCellReuseIdentifier: "groupCell")
        groupTableView.delegate = self
        groupTableView.dataSource = self
        initTopButtons()
        SnapShotTaskEngine.getInstance().doGetGroupShotListTask("", longitude: "", latitude: "", page: "", step: "", sortType: "", engineProtocol: self)
       
    }
    
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        self.title = "一起团拍"
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ViewWidgest.recoverNavigationBar([self.navBtn!, self.priceSortButton!,self.distanceSortButton!,self.dateSortButton!], navigationController: self.navigationController!)
        SnapShotTaskEngine.getInstance().doGetGroupShotListTask("", longitude: "", latitude: "", page: "0", step: "5", sortType: "", engineProtocol: self)
    }
    
    func initTopButtons() {
        self.priceSortButton = UIButton()
        self.distanceSortButton = UIButton()
        self.dateSortButton = UIButton()
        ViewWidgest.navigatiobBarButtomButton([self.priceSortButton!,self.distanceSortButton!,self.dateSortButton!], titleArray: ["价格优先","距离优先","日期优先"], targetArrary: ["priceSortAction" , "distanceSortAction", "dateSortAction"], viewController: self, yPosition: 64)
        
        self.startServiceButton.backgroundColor = SP_BLUE_COLOR
        self.startServiceButton.tintColor = UIColor.white
        self.startServiceButton.setTitle("发起活动", for: UIControlState())
        self.startServiceButton.titleLabel?.font = UIFont(name: HEITI, size: 17)
        self.startServiceButton.layer.borderWidth = 12
        self.startServiceButton.layer.borderColor = BACKGROUND_COLOR_GREY.cgColor
        self.view.addSubview(self.startServiceButton)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var groupCell: GroupCell?
        groupCell = groupTableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell
        if indexPath.section == 0{
            
            groupCell?.groupCellTitleLabel.text = "奥林匹克森林公园"
            groupCell?.groupCellTimeLabel.text = "2015年11月6日14:00-18:00"
            groupCell?.groupCellLocationLabel.text = "北京奥林匹克森林公园"
            groupCell?.groupCellServiceLabel.text = ">60张拍摄，30张精修"
            groupCell?.groupCellMemberNumLabel.text = "3-5个家庭"
            groupCell?.groupCellPhotographerLabel.text = "2"
        } else {
            groupCell?.groupCellImageView.image = UIImage(named: "groupCellImageDefault2")
            groupCell?.groupCellTitleLabel.text = "朝阳公园孕妇周记"
            groupCell?.groupCellTimeLabel.text = "2015年11月6日14:00-18:00"
            groupCell?.groupCellLocationLabel.text = "北京朝阳公园"
            groupCell?.groupCellServiceLabel.text = ">50张拍摄，15张精修"
            groupCell?.groupCellMemberNumLabel.text = "2-3位情侣"
            groupCell?.groupCellPhotographerLabel.text = "1"
        }
        
        
        return groupCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let groupDetailViewController:GroupDetailViewController = GroupDetailViewController(title: "奥森萌娃外拍")
            groupDetailViewController.imageUrlArray = ["http://111.13.47.169:8080/upload/image/custom/tuanpai1-xiangqing1.jpg","http://111.13.47.169:8080/upload/image/custom/tuanpai1-xiangqing2.jpg","http://111.13.47.169:8080/upload/image/custom/tuanpai1-xiangqing3.jpg"]
            self.navigationController?.pushViewController(groupDetailViewController, animated: true)
        } else {
            let groupDetailViewController:GroupDetailViewController = GroupDetailViewController(title: "情侣外拍")
            groupDetailViewController.imageUrlArray = ["http://111.13.47.169:8080/upload/image/custom/tuanpai2-xiangqing1.jpg","http://111.13.47.169:8080/upload/image/custom/tuanpai2-xiangqing2.jpg","http://111.13.47.169:8080/upload/image/custom/tuanpai2-xiangqing3.jpg"]
            self.navigationController?.pushViewController(groupDetailViewController, animated: true)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
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
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func onTaskSuccess(_ taskType: Int!, successCode: Int, extraData: AnyObject) {
        if TASK_TYPE_GET_GROUP_SHOT_LIST == taskType {
            print(extraData)
        }
    }
    
    override func onTaskError(_ taskType: Int!, errorCode: Int, extraData: AnyObject) {
        
    }
    
}
