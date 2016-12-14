//
//  ProfileDetailTableView.swift
//  SnapShot
//
//  Created by Jacob Li on 30/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class PhotographerDetailTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var naviController: UINavigationController?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.naviController = UINavigationController()
        self.dataSource = self
        self.delegate = self
        self.contentSize = CGSize(width: SCREEN_WIDTH, height: 700)
        let nibValueCell = UINib(nibName: "ValueCell", bundle: nil)
        let nibCameraCell = UINib(nibName: "CameraCell", bundle: nil)
        let nibServiceCell = UINib(nibName: "ServiceCell", bundle: nil)
        self.register(nibValueCell, forCellReuseIdentifier: "valueCell")
        self.register(nibCameraCell, forCellReuseIdentifier: "cameraCell")
        self.register(nibServiceCell, forCellReuseIdentifier: "serviceCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //==================UITableViewDataSource====================================================//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if indexPath.section == 0 {
            cell = self.dequeueReusableCell(withIdentifier: "valueCell") as! ValueCell
            return cell!
            
        } else if indexPath.section == 1{
            let detailCell: ServiceCell?
            detailCell = self.dequeueReusableCell(withIdentifier: "serviceCell") as? ServiceCell
            return detailCell!
        } else if indexPath.section == 2 {
            let cameraCell: CameraCell?
            cameraCell = self.dequeueReusableCell(withIdentifier: "cameraCell") as? CameraCell
            return cameraCell!
        } else if indexPath.section == 3{
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "userInfoCell")
            cell?.textLabel?.font = UIFont(name: HEITI, size: CONTENT_FONT_SIZE)
            cell?.detailTextLabel?.font = UIFont(name: HEITI, size: CONTENT_FONT_SIZE)
            cell?.detailTextLabel?.textColor = TEXT_COLOR_GREY
            if indexPath.row == 0 {
                cell?.textLabel?.text = "我的订单"
                cell?.detailTextLabel?.text = "20"
            } else if indexPath.row == 1{
                cell?.textLabel?.text = "我的收藏"
                cell?.detailTextLabel?.text = "48"
            } else {
                cell?.textLabel?.text = "我的红包"
                cell?.detailTextLabel?.text = "16"
            }
            return cell!
        } else {
            cell = UITableViewCell()
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return 3
        } else {
            return 1
        }
    }
    
    //==================UITableViewDelegate===========================================================//
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return VALUE_CELL_HEIGHT
        } else if indexPath.section == 1{
            return SERVICE_CELL_HEIGHT
        } else if indexPath.section == 2{
            return CAMERA_CELL_HEIGHT
        } else if indexPath.section == 3{
            return USER_INFO_CELL_HEIGHT
        } else {
            return 200
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
        if section == 2 {
            return 90
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 || indexPath.row == 0 {
            let myOrderViewController = MyOrderViewController(title: "我的订单")
            let navigationViewController = UINavigationController()
            navigationViewController.pushViewController(myOrderViewController, animated: true)
        }
    }
}
