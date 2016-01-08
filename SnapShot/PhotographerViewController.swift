//
//  profileViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 23/10/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class PhotographerViewController: BasicViewController {
    
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileUserIDLabel: UILabel!
    @IBOutlet weak var profileAppointLabel: UILabel!

    
    var profileBtn: UIButton = UIButton()
    var artsDisplayBtn: UIButton = UIButton()
    var commentDisplayBtn: UIButton = UIButton()
    var photographerDetailTableView: PhotographerDetailTableView?
    var artsDisplayTableView: ArtsDisplayTableView?
    var commentDisplayTableVeiw: CommentDisplayTableView?
    var startServiceButton: UIButton = UIButton(frame: CGRect(x: 20, y: SCREEN_HEIGHT - 60, width: SCREEN_WIDTH - 40, height: 60))
    var shareButton = ViewWidgest.addRightButton("shareImage", imageAfter: "shareImage")
    
    var artsImageArray: [String]!
    
    override func viewWillAppear(animated: Bool) {
        
        
        ViewWidgest.navigatiobBarButtomButton([self.profileBtn, self.artsDisplayBtn, self.commentDisplayBtn], titleArray: ["基本资料","作品展示","用户评论"], targetArrary: ["profileBtnAction","artsDisplayBtnAction","commentDisplayBtnAction"], viewController: self, yPosition: 227)
        self.profileBtn.selected = true
        
        self.navigationController?.navigationBar.addSubview(self.shareButton)
        
        
        self.startServiceButton.backgroundColor = SP_BLUE_COLOR
        self.startServiceButton.tintColor = UIColor.whiteColor()
        self.startServiceButton.setTitle("发起活动", forState: .Normal)
        self.startServiceButton.titleLabel?.font = UIFont(name: HEITI, size: 17)
        self.startServiceButton.layer.borderWidth = 12
        self.startServiceButton.layer.borderColor = BACKGROUND_COLOR_GREY.CGColor
        
        let tableRect = CGRect(x: 0, y: 265, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 260)
        
        self.photographerDetailTableView = PhotographerDetailTableView(frame: tableRect, style: UITableViewStyle.Grouped)
        self.artsDisplayTableView = ArtsDisplayTableView(frame: tableRect, style: UITableViewStyle.Grouped, numberOfSection: 5)
        self.commentDisplayTableVeiw = CommentDisplayTableView(frame: tableRect, style: UITableViewStyle.Grouped, numberOfSection: 1)
        
        if self.profileBtn.selected == true {
            self.view.addSubview(self.photographerDetailTableView!)
            self.view.addSubview(self.startServiceButton)
        }
    }
    
    
    override func viewDidLoad() {
        self.title = "我的咔嚓"
        self.artsImageArray = ["http://f.hiphotos.baidu.com/image/pic/item/574e9258d109b3de71ab648fc8bf6c81810a4cc5.jpg","http://c.hiphotos.baidu.com/image/pic/item/8326cffc1e178a82f3fcfe47f203738da877e811.jpg", "http://a.hiphotos.baidu.com/image/pic/item/adaf2edda3cc7cd94d3cb43e3d01213fb90e91c0.jpg","http://b.hiphotos.baidu.com/image/pic/item/f636afc379310a55f2505e13b34543a9832610e4.jpg"]
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.shareButton.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func profileBtnAction() {
        if self.profileBtn.selected == false {
            self.profileBtn.selected = true
            self.artsDisplayBtn.selected = false
            self.commentDisplayBtn.selected = false
            self.artsDisplayTableView?.removeFromSuperview()
            self.commentDisplayTableVeiw?.removeFromSuperview()
            self.view.addSubview(self.photographerDetailTableView!)
            self.startServiceButton.removeFromSuperview()
            self.view.addSubview(self.startServiceButton)
        }
    }
    
    func artsDisplayBtnAction() {
        if self.artsDisplayBtn.selected == false {
            self.artsDisplayBtn.selected = true
            self.profileBtn.selected = false
            self.commentDisplayBtn.selected = false
            self.photographerDetailTableView?.removeFromSuperview()
            self.commentDisplayTableVeiw?.removeFromSuperview()
            self.view.addSubview(self.artsDisplayTableView!)
            self.startServiceButton.removeFromSuperview()
        }
    }
    
    func commentDisplayBtnAction() {
        if self.commentDisplayBtn.selected == false {
            self.commentDisplayBtn.selected = true
            self.artsDisplayBtn.selected = false
            self.profileBtn.selected = false
            self.photographerDetailTableView?.removeFromSuperview()
            self.artsDisplayTableView?.removeFromSuperview()
            self.view.addSubview(self.commentDisplayTableVeiw!)
            self.startServiceButton.removeFromSuperview()
        }
        
    }
    
    func pushView() {
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
    
    
}