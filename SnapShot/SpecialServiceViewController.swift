//
//  SpecialServiceViewController.swift
//  SnapShot
//
//  Created by RANRAN on 17/01/2016.
//  Copyright © 2016 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class SpecialServiceViewController: BasicViewController, UITableViewDelegate, UITableViewDataSource {
    var specialSeviceTableView: UITableView?
    
    override func viewDidLoad() {
        specialSeviceTableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT) , style: .Plain)
        self.view.addSubview(specialSeviceTableView!)
        specialSeviceTableView!.registerNib(UINib(nibName: "CataCell", bundle: nil), forCellReuseIdentifier: "cataCell")
        specialSeviceTableView?.delegate = self
        specialSeviceTableView?.dataSource = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CATA_CELL_HEIGHT
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cataCell = specialSeviceTableView!.dequeueReusableCellWithIdentifier("cataCell") as? CataCell
        cataCell?.cataLabel.text = "星球大战剧照"
        
        return cataCell!
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let specialServiceDetailViewController = SpecialServiceDetailViewController(title: "星球大战剧照")
        self.navigationController?.pushViewController(specialServiceDetailViewController, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
}