//
//  CouponViewController.swift
//  SnapShot
//
//  Created by RANRAN on 01/12/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class CouponViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var sectionNumber: Int?
    var couponTableView: UITableView?
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        self.title = "优惠活动"
        self.couponTableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .grouped)
        self.couponTableView?.contentSize = CGSize(width: SCREEN_WIDTH, height: 700)
        self.couponTableView?.delegate = self
        self.couponTableView?.dataSource = self
        let nibCouponCell =  UINib(nibName: "CouponCell", bundle: nil)
        self.couponTableView!.register(nibCouponCell, forCellReuseIdentifier: "couponCell")
        self.view.addSubview(self.couponTableView!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    //==================UITableViewDataSource====================================================//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if indexPath.section == 0 {
            cell = UITableViewCell(style: .default, reuseIdentifier: "couponHeaderCell")
            cell?.frame = CGRect(x: 0, y: 44, width: SCREEN_WIDTH, height: 280)
            let headerImageView = UIImageView(image: UIImage(named: "cataImageDefault"))
            headerImageView.frame = CGRect(x: 20, y: -40, width: SCREEN_WIDTH - 40, height: 280)
            headerImageView.contentMode = .scaleAspectFit
            let headerCoverImageView = UIImageView(image: UIImage(named: "couponHeaderCoverImage"))
            headerCoverImageView.frame = CGRect(x: 20, y: -40, width: SCREEN_WIDTH - 40, height: 280)
            headerCoverImageView.contentMode = .scaleAspectFit
            
            let couponLabel = UILabel(frame: CGRect(x: 95, y: 60, width: SCREEN_WIDTH - 190, height: 30))
            couponLabel.text = "邀请好友拿红包"
            couponLabel.textColor = UIColor.white
            couponLabel.font = UIFont(name: HEITI, size: 25)
            
            
            let couponInfoLabel = UILabel(frame: CGRect(x: 50, y: 80, width: SCREEN_HEIGHT - 100, height: 80))
            couponInfoLabel.text = "为好友的第一次拍摄送上50元红包\n好友预约拍摄时，您也将自动获得50元红包"
            couponInfoLabel.textColor = UIColor.white
//            couponInfoLabel.textAlignment = .Center
            
            
            let checkDetailLabel = UILabel(frame: CGRect(x: 20, y: 180, width: 80, height: 40))
            checkDetailLabel.text = "查看详情"
            checkDetailLabel.textColor = TEXT_COLOR_GREY
            checkDetailLabel.tintColor = TEXT_COLOR_GREY
            checkDetailLabel.font = UIFont(name: HEITI, size: 15)
            
            
            cell?.addSubview(headerImageView)
            cell?.addSubview(headerCoverImageView)
            cell?.addSubview(couponLabel)
            cell?.addSubview(couponInfoLabel)
            cell?.addSubview(checkDetailLabel)
        
            return cell!

        } else {
            let couponCell = self.couponTableView?.dequeueReusableCell(withIdentifier: "couponCell") as? CouponCell
            if indexPath.row == 0 {
                couponCell?.couponValueLabel.text = "10"
                couponCell?.couponConditionLabel.text = "满100元即可使用"
            } else if indexPath.row == 1 {
                couponCell?.couponValueLabel.text = "50"
                couponCell?.couponConditionLabel.text = "满150元即可使用"
            } else {
                couponCell?.couponValueLabel.text = "30"
                couponCell?.couponConditionLabel.text = "满120元即可使用"
            }
            return couponCell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 5
        }
    }
    
    //==================UITableViewDelegate===========================================================//
    func numberOfSections(in tableView: UITableView) -> Int {
       return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return COUPON_HEADER_CELL_HEIGHT
        } else {
            return COUPON_CELL_HEIGHT
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func checkDetailBtnAction() {
    
    }

}
