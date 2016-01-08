//
//  CataViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 09/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

class CataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HttpProtocol {
    
    @IBOutlet weak var cataTableView: UITableView!
    var cataTitle: [String] = []
    var cataImage: [String] = []
    
    override func viewWillAppear(animated: Bool) {
        self.getCataImage()
    }
    
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
//            cataDetailCell?.cataImage1.image = UIImage(named: "cataImageDefault")
//            cataDetailCell?.cataImage2.image = UIImage(named: "cataImageDefault")
            cataDetailCell?.cataLabel1.textColor = UIColor.whiteColor()
            cataDetailCell?.cataLabel2.textColor = UIColor.whiteColor()
            cataDetailCell?.cataLabel1.text = ""
            cataDetailCell?.cataLabel2.text = ""
            
            if indexPath.row == 0 {
                if self.cataTitle.count > 0 {
                    cataDetailCell?.cataImage1.hnk_setImageFromURL(NSURL(string: self.cataImage[indexPath.row])!)
                    cataDetailCell?.cataImage2.hnk_setImageFromURL(NSURL(string: self.cataImage[indexPath.row + 1])!)
//                    cataDetailCell?.cataLabel1.text = self.cataTitle[indexPath.row]
//                    cataDetailCell?.cataLabel2.text = self.cataTitle[indexPath.row + 1]
                }
                return cataDetailCell!
            } else if indexPath.row == 1 {
                if self.cataTitle.count > 0 {
                    cataDetailCell?.cataImage1.hnk_setImageFromURL(NSURL(string: self.cataImage[2])!)
                    cataDetailCell?.cataImage2.hnk_setImageFromURL(NSURL(string: self.cataImage[3])!)
//                    cataDetailCell?.cataLabel1.text = self.cataTitle[2]
//                    cataDetailCell?.cataLabel2.text = self.cataTitle[3]
                }
                return cataDetailCell!
            } else if indexPath.row == 2 {
                if self.cataTitle.count > 0 {
                    cataDetailCell?.cataImage1.hnk_setImageFromURL(NSURL(string: self.cataImage[4])!)
                    cataDetailCell?.cataImage2.hnk_setImageFromURL(NSURL(string: self.cataImage[5])!)
//                    cataDetailCell?.cataLabel1.text = self.cataTitle[4]
//                    cataDetailCell?.cataLabel2.text = self.cataTitle[5]
                }
                return cataDetailCell!
            } else {
                if self.cataTitle.count > 0 {
                    cataDetailCell?.cataImage1.hnk_setImageFromURL(NSURL(string: self.cataImage[6])!)
                    cataDetailCell?.cataImage2.hnk_setImageFromURL(NSURL(string: self.cataImage[7])!)
//                    cataDetailCell?.cataLabel1.text = self.cataTitle[6]
//                    cataDetailCell?.cataLabel2.text = self.cataTitle[7]
                }
                return cataDetailCell!
            }
        }
        
    }
    
    func getCataImage() {
        let timeStamp = ToolKit.getTimeStamp()
        let sig = "GEThttp://111.13.47.169:8080/materials/categoriestime=\(timeStamp)f4a8yoxG9F6b1gUB"
        let urlAssembler = UrlAssembler(taskUrl: "http://111.13.47.169:8080/materials/categories", parameterDictionary: ["time": timeStamp], signiture: sig.md5)
        let httpControl = HttpControl(delegate: self)
        httpControl.onRequest(urlAssembler.url)
    }
    
    func didRecieveResults(results: AnyObject) {
        print(results)
        if JSON(results)["succeed"].int! == 1 {
            print(JSON(results)["data"]["items"])
            
            var sampleString: String = JSON(results)["data"]["items"].string!
            sampleString = sampleString.stringByReplacingOccurrencesOfString("[", withString: "")
            sampleString = sampleString.stringByReplacingOccurrencesOfString("]", withString: "")
            sampleString = sampleString.stringByReplacingOccurrencesOfString("\"", withString: "")
            sampleString = sampleString.stringByReplacingOccurrencesOfString("title", withString: "")
            sampleString = sampleString.stringByReplacingOccurrencesOfString("url", withString: "")
            sampleString = sampleString.stringByReplacingOccurrencesOfString(":", withString: "")
            var tempArr = sampleString.componentsSeparatedByString("},{")
           
            tempArr[0] = tempArr[0].stringByReplacingOccurrencesOfString("{", withString: "")
            tempArr[tempArr.count - 1] = tempArr[tempArr.count - 1].stringByReplacingOccurrencesOfString("}", withString: "")
            for var i = 0; i < tempArr.count; i++ {
                let tempValue = tempArr[i].componentsSeparatedByString(",")
                self.cataTitle.append(tempValue[0])
                self.cataImage.append((tempValue[1].stringByReplacingOccurrencesOfString("8080", withString: ":8080")).stringByReplacingOccurrencesOfString("http", withString: "http:"))
                
            }
            self.cataTableView.reloadData()
        } else {
            
            
            didRecieveError("requestFailed")
        }
        print("httpProtocol is called")
    }
    
    func didRecieveError(error: AnyObject) {
        print("httpProtocol is called")
    }

}