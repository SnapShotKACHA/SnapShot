//
//  CataViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 09/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class CataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var cataTableView: UITableView!
    
    override func viewDidLoad() {
        self.title = "摄影分类"
        cataTableView.registerNib(UINib(nibName: "CataDetailCell", bundle: nil), forCellReuseIdentifier: "cataDetailCell")
        cataTableView.registerNib(UINib(nibName: "CataCell", bundle: nil), forCellReuseIdentifier: "cataCell")
        cataTableView.delegate = self
        cataTableView.dataSource = self
        cataTableView.separatorColor = UIColor.clearColor()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 4
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CATA_CELL_HEIGHT
        } else {
            return CATA_DETAIL_CELL_HEIGHT
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cataCell: CataCell?
        var cataDetailCell: CataDetailCell?
        
        if indexPath.section == 0 && indexPath.row == 0{

            cataCell = cataTableView.dequeueReusableCellWithIdentifier("cataCell") as? CataCell
            cataCell?.cataLabel.text = "萌娃外拍"
            cataCell?.cataImageView.image = UIImage(named: "cataImageDefault")
            return cataCell!
        } else {

            cataDetailCell = cataTableView.dequeueReusableCellWithIdentifier("cataDetailCell") as? CataDetailCell
            cataDetailCell?.cataImage1.image = UIImage(named: "cataImageDefault")
            cataDetailCell?.cataImage2.image = UIImage(named: "cataImageDefault")
            cataDetailCell?.cataLabel1.text = "测试标题"
            cataDetailCell?.cataLabel2.text = "测试标题"
            return cataDetailCell!
        }
        
    }
}