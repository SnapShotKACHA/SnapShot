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
    override func viewWillAppear(_ animated: Bool) {
        SnapShotTaskEngine.getInstance().doGetSpecialShotListTask("", longitude: "", latitude: "", page: "0", step: "5", engineProtocol: self)
    }
    
    override func viewDidLoad() {
        self.title = "特色服务"
        specialSeviceTableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT) , style: .plain)
        self.view.addSubview(specialSeviceTableView!)
        specialSeviceTableView!.register(UINib(nibName: "CataCell", bundle: nil), forCellReuseIdentifier: "cataCell")
        specialSeviceTableView?.delegate = self
        specialSeviceTableView?.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.specialShotModelArray.removeAll()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CATA_CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cataCell = specialSeviceTableView!.dequeueReusableCell(withIdentifier: "cataCell") as? CataCell
        cataCell?.cataLabel.text = "星球大战剧照"
        
        if specialShotModelArray.count > 0 {
            let index = indexPath.section
            cataCell?.cataImageView.hnk_setImageFromURL(URL(string: specialShotModelArray[index].getPicUrl())!)
            cataCell?.cataIntroLabel.text = specialShotModelArray[index].getTitle()
            cataCell?.cataLabel.text = specialShotModelArray[index].getIntro()
            cataCell?.priceLabel.text = "\(specialShotModelArray[index].getPrice())元"
        }
        
        return cataCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return specialShotModelArray.count > 0 ? specialShotModelArray.count : 3
    }
    
    
    override func onTaskSuccess(_ taskType: Int!, successCode: Int, extraData: AnyObject) {
        if String(describing: extraData) != nil {
            
            let itemsString = JSON(extraData)[JSON_KEY_DATA][JSON_KEY_ITEMS].string
            let itemsData = itemsString?.data(using: String.Encoding.utf8)
            
            let jsonArr = try!JSONSerialization.jsonObject(with: itemsData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
            //
            
            for item in jsonArr {
                let picUrl = item.object(forKey: JSON_KEY_PIC_URL) as! String
                let price = item.object(forKey: JSON_KEY_PRICE) as! String
                let intro = item.object(forKey: JSON_KEY_INTRO) as! String
                let title = item.object(forKey: JSON_KEY_TITLE) as! String
                
                let specialShot: SpecialShotModel = SpecialShotModel(picUrlValue: picUrl, priceValue: price, titleValue: intro, introValeu: title)
                self.specialShotModelArray.append(specialShot)
                
            }
            
            self.specialSeviceTableView!.reloadData()
        }

    }
    
    
    override func onTaskError(_ taskType: Int!, errorCode: Int, extraData: AnyObject) {
        
    }
}
