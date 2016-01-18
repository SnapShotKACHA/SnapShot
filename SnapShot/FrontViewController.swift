//
//  ViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 09/10/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FrontViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SlideScrollViewDelegate, SnapShotEngineProtocol{
    var navBtn: UIButton?
    var imageUrl: [String] = []
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        if self.navBtn == nil {
        self.navBtn = ViewWidgest.addLeftButton("navigationButtonImage", imageAfter: "navigationButtonImage")
        self.navBtn?.addTarget(AppDelegate(), action: "leftViewShowAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationController?.navigationBar.addSubview(self.navBtn!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mainTableView.registerNib(UINib(nibName: "FrontCell", bundle: nil), forCellReuseIdentifier: "frontCell")
        mainTableView.registerNib(UINib(nibName: "CataCell", bundle: nil), forCellReuseIdentifier: "cataCell")
        mainTableView.separatorColor = UIColor.clearColor()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "popToSearchViewController")
    }

    override func viewWillDisappear(animated: Bool) {
        self.navBtn?.removeFromSuperview()
        self.navBtn = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  section == 0 {
            
            return 2
        }else {
            
            return 1
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 44
        } else if indexPath.section == 0 && indexPath.row == 1 {
            return CATA_CELL_HEIGHT
        } else {
            return FRONT_CELL_HEIGHT
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        var cataCell: CataCell?
        
        if indexPath.section == 0 && indexPath.row == 0 {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
            cell.backgroundColor = UIColor.clearColor()
            cell.contentView.backgroundColor = UIColor.clearColor()
            cell.clipsToBounds = true
            return cell
        } else if indexPath.section == 0 && indexPath.row == 1 {
            cataCell = CataCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cataCell")
            cataCell = mainTableView.dequeueReusableCellWithIdentifier("cataCell") as? CataCell
            cataCell?.cataLabel.text = "星球大战邀你来战"
            cataCell?.cataImageView.image = UIImage(named: "cataImageDefault")            
            return cataCell!

        } else {
            
            let frontCell = self.mainTableView.dequeueReusableCellWithIdentifier("frontCell") as? FrontCell
            let tapRecognizer = UITapGestureRecognizer(target: self, action: "pushToPhotograher")
            frontCell!.userIDLabel.userInteractionEnabled = true
            print(indexPath.row)
            
            if self.imageUrl.count > 0 {
                print(self.imageUrl[indexPath.row])
                frontCell!.artImageView.hnk_setImageFromURL(NSURL(string: self.imageUrl[indexPath.section])!)
            }
            frontCell!.addGestureRecognizer(tapRecognizer)
            return frontCell!
        }
    }


    private func doReturnCell(row:Int) -> UITableViewCell {
        
        let cell = mainTableView.dequeueReusableCellWithIdentifier("frontCell") as! FrontCell
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "pushToPhotograher")
        cell.userIDLabel.userInteractionEnabled = true
        print(row)
        print(self.imageUrl)
        if self.imageUrl.count > 0 {
            cell.artImageView.hnk_setImageFromURL(NSURL(string: self.imageUrl[row])!)
        }
        cell.addGestureRecognizer(tapRecognizer)
        return cell
    }
    
    func pushToPhotograher() {
        let profileviewController =  UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("profileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(profileviewController, animated: true)
    }
    
    
    //=======================UITableViewDelegate 的实现===================================
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
                return 0
        }
        
        return CGFloat(SECTION_HEIGHT)
    }
    
    func SlideScrollViewDidClicked(index: Int) {
        print(index)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func onTaskSuccess(taskType: Int!, successCode: Int, extraData: AnyObject) {
        print("FrontViewController, onTaskSuccess")
        if (TASK_TYPE_GET_HOME_PAGES == taskType) {
            print("get home pages task success!")
            let sampleString: String! = extraData as! String
            self.imageUrl = sampleString.componentsSeparatedByString(",")
            self.mainTableView.reloadData()
        }
    }
    
    func onTaskError(taskType: Int!, errorCode: Int, extraData: AnyObject) {
        print("FrontViewController, onTaskError, handle please!")
    }
    
}

