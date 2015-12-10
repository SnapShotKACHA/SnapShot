//
//  profileViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 23/10/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: BasicViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileUserIDLabel: UILabel!
    @IBOutlet weak var profileAppointLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    

    
    var artsImageArray: [String]!
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.hidden = true
        let leftButton = ViewWidgest.addLeftButton("backButtonImage", imageAfter: "backButtonImage")
        self.headImageView.addSubview(leftButton)
        leftButton.addTarget(self, action: "pushView", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.profileTableView.scrollEnabled = false
        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        self.profileTableView.separatorColor = UIColor.clearColor()
        
        self.artsImageArray = ["http://f.hiphotos.baidu.com/image/pic/item/574e9258d109b3de71ab648fc8bf6c81810a4cc5.jpg","http://c.hiphotos.baidu.com/image/pic/item/8326cffc1e178a82f3fcfe47f203738da877e811.jpg", "http://a.hiphotos.baidu.com/image/pic/item/adaf2edda3cc7cd94d3cb43e3d01213fb90e91c0.jpg","http://b.hiphotos.baidu.com/image/pic/item/f636afc379310a55f2505e13b34543a9832610e4.jpg"]
        let nibPC = UINib(nibName: "ProfileCell", bundle: nil)
        let nibVC = UINib(nibName: "ValueCell", bundle: nil)
        self.profileTableView.registerNib(nibPC, forCellReuseIdentifier: "profileCell")
        self.profileTableView.registerNib(nibVC, forCellReuseIdentifier: "valueCell")
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    //==================UITableViewDataSource====================================================//
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if indexPath.section == 0 {
            cell = self.profileTableView.dequeueReusableCellWithIdentifier("profileCell", forIndexPath: indexPath) as! ProfileCell
            cell?.backgroundColor = UIColor(red: 2/255, green: 191/255, blue: 141/255, alpha: 1)
            return cell!
        } else {
            cell = self.profileTableView.dequeueReusableCellWithIdentifier("valueCell", forIndexPath: indexPath) as! ValueCell
            cell?.backgroundColor = UIColor(red: 6/255, green: 191/255, blue: 191/255, alpha: 1)
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //==================UITableViewDelegate===========================================================//
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CGFloat(PROFILE_CELL_HEIGHT)
        } else {
            return CGFloat(VALUE_CELL_HEIGHT)
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    func pushView() {
        self.navigationController!.popToRootViewControllerAnimated(true)
    }

    
}