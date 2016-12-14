//
//  SpecialServiceViewController.swift
//  SnapShot
//
//  Created by RANRAN on 17/01/2016.
//  Copyright © 2016 Jacob Li. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class SpecialServiceViewController: BasicViewController, UITableViewDelegate, UITableViewDataSource {
    var specialSeviceTableView: UITableView?
    var specialShotModelArray: [SpecialShotModel] = []
    override func viewWillAppear(animated: Bool) {
        SnapShotTaskEngine.getInstance().doGetSpecialShotListTask("", longitude: "", latitude: "", page: "0", step: "5", engineProtocol: self)
    }
    
    override func viewDidLoad() {
        self.title = "特色服务"
        specialSeviceTableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT) , style: .Plain)
        self.view.addSubview(specialSeviceTableView!)
        specialSeviceTableView!.registerNib(UINib(nibName: "CataCell", bundle: nil), forCellReuseIdentifier: "cataCell")
        specialSeviceTableView?.delegate = self
        specialSeviceTableView?.dataSource = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.specialShotModelArray.removeAll()
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
        
        if specialShotModelArray.count > 0 {
            let index = indexPath.section
            cataCell?.cataImageView.hnk_setImageFromURL(NSURL(string: specialShotModelArray[index].getPicUrl())!)
            cataCell?.cataIntroLabel.text = specialShotModelArray[index].getTitle()
            cataCell?.cataLabel.text = specialShotModelArray[index].getIntro()
            cataCell?.priceLabel.text = "\(specialShotModelArray[index].getPrice())元"
        }
        
        return cataCell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            let specialServiceDetailViewController = SpecialServiceDetailViewController(title: self.specialShotModelArray[indexPath.section].getIntro())
            specialServiceDetailViewController.specialShotModel = SpecialShotModel(picUrlValue: "", priceValue: "", titleValue: "", introValeu: "")
            specialServiceDetailViewController.specialShotModel = self.specialShotModelArray[indexPath.section]
            specialServiceDetailViewController.imageUrlArray = ["http://111.13.47.169:8080/upload/image/custom/special1-xiangqing1.jpg","http://111.13.47.169:8080/upload/image/custom/special1-xiangqing2.jpg","http://111.13.47.169:8080/upload/image/custom/special1-xiangqing3.jpg"]
            self.navigationController?.pushViewController(specialServiceDetailViewController, animated: true)
        } else if indexPath.section == 1 {
            let specialServiceDetailViewController = SpecialServiceDetailViewController(title: self.specialShotModelArray[indexPath.section].getIntro())
            specialServiceDetailViewController.specialShotModel = SpecialShotModel(picUrlValue: "", priceValue: "", titleValue: "", introValeu: "")
            specialServiceDetailViewController.specialShotModel = self.specialShotModelArray[indexPath.section]
            specialServiceDetailViewController.imageUrlArray = ["http://111.13.47.169:8080/upload/image/custom/special2-xiangqing1.jpg","http://111.13.47.169:8080/upload/image/custom/special2-xiangqing2.jpg","http://111.13.47.169:8080/upload/image/custom/special2-xiangqing3.jpg"]
            self.navigationController?.pushViewController(specialServiceDetailViewController, animated: true)
        } else {
            let specialServiceDetailViewController = SpecialServiceDetailViewController(title: self.specialShotModelArray[indexPath.section].getIntro())
            specialServiceDetailViewController.specialShotModel = SpecialShotModel(picUrlValue: "", priceValue: "", titleValue: "", introValeu: "")
            specialServiceDetailViewController.specialShotModel = self.specialShotModelArray[indexPath.section]
            self.navigationController?.pushViewController(specialServiceDetailViewController, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return specialShotModelArray.count > 0 ? specialShotModelArray.count : 3
    }
    
    
    override func onTaskSuccess(taskType: Int!, successCode: Int, extraData: AnyObject) {
        if String(extraData) != nil {
            
            let itemsString = JSON(extraData)[JSON_KEY_DATA][JSON_KEY_ITEMS].string
            let itemsData = itemsString?.dataUsingEncoding(NSUTF8StringEncoding)
            
            let jsonArr = try!NSJSONSerialization.JSONObjectWithData(itemsData!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            //
            
            for item in jsonArr {
                let picUrl = item.objectForKey(JSON_KEY_PIC_URL) as! String
                let price = item.objectForKey(JSON_KEY_PRICE) as! String
                let intro = item.objectForKey(JSON_KEY_INTRO) as! String
                let title = item.objectForKey(JSON_KEY_TITLE) as! String
                
                let specialShot: SpecialShotModel = SpecialShotModel(picUrlValue: picUrl, priceValue: price, titleValue: intro, introValeu: title)
                self.specialShotModelArray.append(specialShot)
                
            }
            
            self.specialSeviceTableView!.reloadData()
        }

    }
    
    
    override func onTaskError(taskType: Int!, errorCode: Int, extraData: AnyObject) {
        
    }
}