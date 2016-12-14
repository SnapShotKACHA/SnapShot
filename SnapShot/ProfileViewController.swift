//
//  profileViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 23/10/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: BasicViewController {
    
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileUserIDLabel: UILabel!
    @IBOutlet weak var profileAppointLabel: UILabel!
    @IBOutlet weak var profileMarkLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    
    var photographerModel: PhotographerIntroduceModel?
    var profileBtn: UIButton = UIButton()
    var artsDisplayBtn: UIButton = UIButton()
    var commentDisplayBtn: UIButton = UIButton()
    var profileDetailTableView: ProfileDetailTableView?
    var artsDisplayTableView: ArtsDisplayTableView?
    var commentDisplayTableVeiw: CommentDisplayTableView?
    var appointButton: UIButton = UIButton(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 60, width: SCREEN_WIDTH, height: 60))
    var commentButton: UIButton = UIButton(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 60, width: SCREEN_WIDTH, height: 60))
    var commentView  = UIView(frame: CGRect(x: 20, y: SCREEN_HEIGHT/2 - 40, width: SCREEN_WIDTH-40, height: 180))
    
    var artsImageArray: [String]!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
      
        ViewWidgest.navigatiobBarButtomButton([self.profileBtn, self.artsDisplayBtn, self.commentDisplayBtn], titleArray: ["基本资料","作品展示","用户评论"], targetArrary: ["profileBtnAction","artsDisplayBtnAction","commentDisplayBtnAction"], viewController: self, yPosition: 227)
        leftBtn.addTarget(self, action: #selector(ProfileViewController.pushView), for: UIControlEvents.touchUpInside)
        self.profileBtn.isSelected = true
        
        self.appointButton.backgroundColor = SP_BLUE_COLOR
        self.appointButton.tintColor = UIColor.white
        self.appointButton.setTitle("立即预约", for: UIControlState())
        self.appointButton.titleLabel?.font = UIFont(name: HEITI, size: 17)
        self.appointButton.layer.borderWidth = 12
        self.appointButton.layer.borderColor = BACKGROUND_COLOR_GREY.cgColor
        self.appointButton.addTarget(self, action: #selector(ProfileViewController.makeAppointmentAction), for: UIControlEvents.touchUpInside)
        
        self.commentButton.backgroundColor = SP_BLUE_COLOR
        self.commentButton.tintColor = UIColor.white
        self.commentButton.setTitle("发表评论", for: UIControlState())
        self.commentButton.titleLabel?.font = UIFont(name: HEITI, size: 17)
        self.commentButton.layer.borderWidth = 12
        self.commentButton.layer.borderColor = BACKGROUND_COLOR_GREY.cgColor
        self.commentButton.addTarget(self, action: #selector(ProfileViewController.makeCommentAction), for: UIControlEvents.touchUpInside)
        
        let tableRect = CGRect(x: 0, y: 265, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 245)
        
        self.profileDetailTableView = ProfileDetailTableView(frame: tableRect, style: UITableViewStyle.grouped)
        self.artsDisplayTableView = ArtsDisplayTableView(frame: tableRect, style: UITableViewStyle.grouped, numberOfSection: 5)
        self.commentDisplayTableVeiw = CommentDisplayTableView(frame: tableRect, style: UITableViewStyle.grouped, numberOfSection: 1)
        
        if self.profileBtn.isSelected == true {
            self.view.addSubview(self.profileDetailTableView!)
            self.view.addSubview(self.appointButton)
        }
        
        if self.photographerModel != nil {
            self.profileUserIDLabel.text = photographerModel?.getNickname()
            self.profileImageView.hnk_setImageFromURL(URL(string: photographerModel!.getAvatar())!)
            self.headImageView.hnk_setImageFromURL(URL(string: photographerModel!.getPicUrl())!)
            self.profileAppointLabel.text = photographerModel?.getAppointmentCount()
        }
    }
    
    
    override func viewDidLoad() {
        self.artsImageArray = ["http://f.hiphotos.baidu.com/image/pic/item/574e9258d109b3de71ab648fc8bf6c81810a4cc5.jpg","http://c.hiphotos.baidu.com/image/pic/item/8326cffc1e178a82f3fcfe47f203738da877e811.jpg", "http://a.hiphotos.baidu.com/image/pic/item/adaf2edda3cc7cd94d3cb43e3d01213fb90e91c0.jpg","http://b.hiphotos.baidu.com/image/pic/item/f636afc379310a55f2505e13b34543a9832610e4.jpg"]
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func profileBtnAction() {
        if self.profileBtn.isSelected == false {
            self.profileBtn.isSelected = true
            self.artsDisplayBtn.isSelected = false
            self.commentDisplayBtn.isSelected = false
            self.artsDisplayTableView?.removeFromSuperview()
            self.commentDisplayTableVeiw?.removeFromSuperview()
            self.view.addSubview(self.profileDetailTableView!)
            self.appointButton.removeFromSuperview()
            self.view.addSubview(self.appointButton)
        }
    }
    
    func artsDisplayBtnAction() {
        if self.artsDisplayBtn.isSelected == false {
            self.artsDisplayBtn.isSelected = true
            self.profileBtn.isSelected = false
            self.commentDisplayBtn.isSelected = false
            self.profileDetailTableView?.removeFromSuperview()
            self.commentDisplayTableVeiw?.removeFromSuperview()
            self.view.addSubview(self.artsDisplayTableView!)
            self.appointButton.removeFromSuperview()
            
        }
    }
    
    func commentDisplayBtnAction() {
        if self.commentDisplayBtn.isSelected == false {
            self.commentDisplayBtn.isSelected = true
            self.artsDisplayBtn.isSelected = false
            self.profileBtn.isSelected = false
            self.profileDetailTableView?.removeFromSuperview()
            self.artsDisplayTableView?.removeFromSuperview()
            self.view.addSubview(self.commentDisplayTableVeiw!)
            self.appointButton.removeFromSuperview()
            self.view.addSubview(self.commentButton)
        }
    
    }

    func pushView() {
        self.navigationController!.popToRootViewController(animated: true)
    }

    func makeAppointmentAction() {
        let orderDetailViewController = OrderDetailViewController(title: "订单详情")
        self.navigationController?.pushViewController(orderDetailViewController, animated: true)
    }
    
    func makeCommentAction() {
        
        commentView.backgroundColor = TEXT_COLOR_LIGHT_GREY
        let inputField = UITextField (frame: CGRect(x: 10, y: 10, width: commentView.frame.size.width - 20, height: 110))
        inputField.placeholder = "请输入评论"
        inputField.backgroundColor = UIColor.white
        commentView.addSubview(inputField)
        let makeComment = UIButton(frame: CGRect(x: 40, y: 130, width: 100, height: 40))
        makeComment.backgroundColor = SP_BLUE_COLOR
        makeComment.setTitle("发表评论", for:  UIControlState())
        makeComment.addTarget(self, action: #selector(ProfileViewController.makeCommentButtonAction), for: UIControlEvents.touchUpInside)
        commentView.addSubview(makeComment)
        
        let cancelComment = UIButton(frame: CGRect(x: 180, y: 130, width: 100, height: 40))
        cancelComment.backgroundColor = SP_BLUE_COLOR
        cancelComment.setTitle("取消", for:  UIControlState())
        cancelComment.addTarget(self, action: #selector(ProfileViewController.cancelCommentButtonAction), for: UIControlEvents.touchUpInside)
        commentView.addSubview(cancelComment)
        
        self.view.addSubview(commentView)
    }
    
    func makeCommentButtonAction() {
        commentView.removeFromSuperview()
    }
    
    func cancelCommentButtonAction() {
        commentView.removeFromSuperview()
    }
}
