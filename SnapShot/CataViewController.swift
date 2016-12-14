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
    
    override func viewWillAppear(_ animated: Bool) {
        self.getCataImage()
    }
    
    override func viewDidLoad() {
        self.title = "摄影分类"
        cataTableView.register(UINib(nibName: "CataDetailCell", bundle: nil), forCellReuseIdentifier: "cataDetailCell")
        cataTableView.register(UINib(nibName: "CataCell", bundle: nil), forCellReuseIdentifier: "cataCell")
        cataTableView.delegate = self
        cataTableView.dataSource = self
        cataTableView.separatorColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CATA_CELL_HEIGHT
        } else {
            return CATA_DETAIL_CELL_HEIGHT
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cataCell: CataCell?
        var cataDetailCell: CataDetailCell?
        
        if indexPath.section == 0 && indexPath.row == 0{

            cataCell = cataTableView.dequeueReusableCell(withIdentifier: "cataCell") as? CataCell
            cataCell?.cataLabel.text = "萌娃外拍"
            cataCell?.cataImageView.image = UIImage(named: "cataImageDefault")
            return cataCell!
        } else {
            cataDetailCell = cataTableView.dequeueReusableCell(withIdentifier: "cataDetailCell") as? CataDetailCell
//            cataDetailCell?.cataImage1.image = UIImage(named: "cataImageDefault")
//            cataDetailCell?.cataImage2.image = UIImage(named: "cataImageDefault")
            cataDetailCell?.cataLabel1.textColor = UIColor.white
            cataDetailCell?.cataLabel2.textColor = UIColor.white
            cataDetailCell?.cataLabel1.text = ""
            cataDetailCell?.cataLabel2.text = ""
            
            if indexPath.row == 0 {
                if self.cataTitle.count > 0 {
                    cataDetailCell?.cataImage1.hnk_setImageFromURL(URL(string: self.cataImage[indexPath.row])!)
                    cataDetailCell?.cataImage2.hnk_setImageFromURL(URL(string: self.cataImage[indexPath.row + 1])!)
//                    cataDetailCell?.cataLabel1.text = self.cataTitle[indexPath.row]
//                    cataDetailCell?.cataLabel2.text = self.cataTitle[indexPath.row + 1]
                }
                return cataDetailCell!
            } else if indexPath.row == 1 {
                if self.cataTitle.count > 0 {
                    cataDetailCell?.cataImage1.hnk_setImageFromURL(URL(string: self.cataImage[2])!)
                    cataDetailCell?.cataImage2.hnk_setImageFromURL(URL(string: self.cataImage[3])!)
//                    cataDetailCell?.cataLabel1.text = self.cataTitle[2]
//                    cataDetailCell?.cataLabel2.text = self.cataTitle[3]
                }
                return cataDetailCell!
            } else if indexPath.row == 2 {
                if self.cataTitle.count > 0 {
                    cataDetailCell?.cataImage1.hnk_setImageFromURL(URL(string: self.cataImage[4])!)
                    cataDetailCell?.cataImage2.hnk_setImageFromURL(URL(string: self.cataImage[5])!)
//                    cataDetailCell?.cataLabel1.text = self.cataTitle[4]
//                    cataDetailCell?.cataLabel2.text = self.cataTitle[5]
                }
                return cataDetailCell!
            } else {
                if self.cataTitle.count > 0 {
                    cataDetailCell?.cataImage1.hnk_setImageFromURL(URL(string: self.cataImage[6])!)
                    cataDetailCell?.cataImage2.hnk_setImageFromURL(URL(string: self.cataImage[7])!)
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
    
    func didRecieveResults(_ results: AnyObject) {
        print(results)
        if JSON(results)["succeed"].int! == 1 {
            print(JSON(results)["data"]["items"])
            
            var sampleString: String = JSON(results)["data"]["items"].string!
            sampleString = sampleString.replacingOccurrences(of: "[", with: "")
            sampleString = sampleString.replacingOccurrences(of: "]", with: "")
            sampleString = sampleString.replacingOccurrences(of: "\"", with: "")
            sampleString = sampleString.replacingOccurrences(of: "title", with: "")
            sampleString = sampleString.replacingOccurrences(of: "url", with: "")
            sampleString = sampleString.replacingOccurrences(of: ":", with: "")
            var tempArr = sampleString.components(separatedBy: "},{")
           
            tempArr[0] = tempArr[0].replacingOccurrences(of: "{", with: "")
            tempArr[tempArr.count - 1] = tempArr[tempArr.count - 1].replacingOccurrences(of: "}", with: "")
            for var i = 0; i < tempArr.count; i++ {
                let tempValue = tempArr[i].components(separatedBy: ",")
                self.cataTitle.append(tempValue[0])
                self.cataImage.append((tempValue[1].replacingOccurrences(of: "8080", with: ":8080")).replacingOccurrences(of: "http", with: "http:"))
                
            }
            self.cataTableView.reloadData()
        } else {
            
            
            didRecieveError("requestFailed")
        }
        print("httpProtocol is called")
    }
    
    func didRecieveError(_ error: AnyObject) {
        print("httpProtocol is called")
    }

}
