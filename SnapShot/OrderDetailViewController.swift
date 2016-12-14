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
    var orderDetailCancelButton = ViewWidgest.addRightButton("取消")
    init(title:String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.addSubview(self.orderDetailCancelButton)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.orderDetailCancelButton.removeFromSuperview()
    }

    
    override func viewDidLoad() {
        self.orderDetailTableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .plain)
        self.orderDetailTableView?.delegate = self
        self.orderDetailTableView?.dataSource = self
        let nibOrderInfoCell = UINib(nibName: "OrderInfoCell", bundle: nil)
        self.orderDetailTableView?.register(nibOrderInfoCell, forCellReuseIdentifier: "orderInfoCell")
        self.view.addSubview(self.orderDetailTableView!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "orderDetailCell")
        if indexPath.section == 0 {
            let orderImageView = UIImageView(image: UIImage(named: "orderFlowImage"))
            orderImageView.frame = CGRect(x: 5, y: 5, width: SCREEN_WIDTH - 10, height: 50)
            orderImageView.contentMode = .scaleAspectFit
            cell.addSubview(orderImageView)
            return cell
        } else if indexPath.section == 1 {
            let orderInfoCell = self.orderDetailTableView?.dequeueReusableCell(withIdentifier: "orderInfoCell", for: indexPath) as! OrderInfoCell
            orderInfoCell.orderInfoCellServiceLabel.text = "萌娃外拍"
            orderInfoCell.orderInfoCellPhotorLabel.text = "Summer Li"
            orderInfoCell.orderInfoCellDateLabel.text = "2015年12月4日"
            orderInfoCell.orderInfoCellTimeLabel.text = "待与摄影师确认"
            orderInfoCell.orderInfoCellLocationLabel.text = "待与摄影师确认"
            return orderInfoCell
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "收货地址"
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "请填入详细收货地址"
                cell.textLabel?.textColor = TEXT_COLOR_LIGHT_GREY
            }
            return cell
        } else {
            if indexPath.row == 0 {
                cell.textLabel?.text = "支付方式"
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "和包"
                let hePayImage = UIImageView(image: UIImage(named: "hePayImage"))
                hePayImage.frame = CGRect(x: 50, y: 5, width: 30, height: 30)
                hePayImage.contentMode = .scaleAspectFit
                cell.addSubview(hePayImage)
            } else if indexPath.row == 2 {
                cell.detailTextLabel?.text = "20元大红包"
                cell.detailTextLabel?.textColor = TEXT_COLOR_LIGHT_GREY
                cell.textLabel?.text = "使用红包"
            } else if indexPath.row == 3 {
                let actualPriceLabel = UILabel (frame: CGRect(x: 230, y: 15, width: SCREEN_WIDTH - 40, height: 20))
                actualPriceLabel.text = "实付金额 330 元"
                let warningLabel = UILabel (frame: CGRect(x: 50, y: 40, width: SCREEN_WIDTH - 40, height: 20))
                warningLabel.text = "请于15分钟内支付，否则订单将自动取消"
                warningLabel.textColor = TEXT_COLOR_LIGHT_GREY
                cell.addSubview(actualPriceLabel)
                cell.addSubview(warningLabel)
            } else {
                cell.backgroundColor = BACKGROUND_COLOR_GREY
                let payButton = UIButton(frame: CGRect(x: SCREEN_WIDTH - 170, y: 5, width: 150, height: 30))
                payButton.setTitle("确认支付", for: UIControlState())
                payButton.backgroundColor = SP_BLUE_COLOR
                payButton.titleLabel?.textColor = UIColor.white
                cell.addSubview(payButton)
                cell.textLabel?.text = "50%定金：￥165元"
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        } else if indexPath.section == 1 {
            return 200
        } else if indexPath.section == 2 {
            return 40
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 2
        } else if section == 3{
            return 5
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 15
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
}
