//
//  ProfileDetailTableView.swift
//  SnapShot
//
//  Created by Jacob Li on 30/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class ProfileDetailTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
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
        }  else {
            cell = UITableViewCell()
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //==================UITableViewDelegate===========================================================//
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return VALUE_CELL_HEIGHT
        } else if indexPath.section == 1{
            return SERVICE_CELL_HEIGHT
        } else if indexPath.section == 2{
            return CAMERA_CELL_HEIGHT
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
}
