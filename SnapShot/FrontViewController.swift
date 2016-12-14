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
import DGElasticPullToRefresh

class FrontViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SlideScrollViewDelegate, SnapShotEngineProtocol{
    var navBtn: UIButton?
    var imageUrl: [String] = []
    var specialShotModel: SpecialShotModel?
    var photographerIntroduceModel: [PhotographerIntroduceModel] = []
    var refreshViewHeight: CGFloat = 44
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        if self.navBtn == nil {
        self.navBtn = ViewWidgest.addLeftButton("navigationButtonImage", imageAfter: "navigationButtonImage")
        self.navBtn?.addTarget(AppDelegate(), action: "leftViewShowAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationController?.navigationBar.addSubview(self.navBtn!)
        SnapShotTaskEngine.getInstance().doGetRecommendedSpecialShot("", longitude: "", latitude: "", engineProtocol: self)
        SnapShotTaskEngine.getInstance().doGetRecommendedPhotographerTask("13811245934", longitude: "", latitude: "", page: "0", step: "5", engineProtocol: self)
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.registerNib(UINib(nibName: "FrontCell", bundle: nil), forCellReuseIdentifier: "frontCell")
        mainTableView.registerNib(UINib(nibName: "CataCell", bundle: nil), forCellReuseIdentifier: "cataCell")
        mainTableView.separatorColor = UIColor.clearColor()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        initTableView()
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "popToSearchViewController")
    }
    
    func initTableView() {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.frame = CGRectMake(SCREEN_WIDTH / 2 - 20, 84, 40, 40)
        loadingView.tintColor = UIColor(red: 78/255, green: 221/255, blue: 200/255, alpha: 1)
        mainTableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            SnapShotTaskEngine.getInstance().doGetRecommendedSpecialShot("", longitude: "", latitude: "", engineProtocol: self)
            SnapShotTaskEngine.getInstance().doGetRecommendedPhotographerTask("", longitude: "", latitude: "", page: "1", step: "5", engineProtocol: self)
            // Do not forget to call dg_stopLoading() at the end
            self!.refreshViewHeight = 64
            self?.mainTableView.dg_stopLoading()
            }, loadingView: loadingView)
        mainTableView.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        mainTableView.dg_setPullToRefreshBackgroundColor(mainTableView.backgroundColor!)
    
    }
    
    deinit {
        mainTableView.dg_removePullToRefresh()
    }

    override func viewWillDisappear(animated: Bool) {
        self.navBtn?.removeFromSuperview()
        self.navBtn = nil
        self.photographerIntroduceModel.removeAll()
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
            return refreshViewHeight
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
            
            if specialShotModel != nil {
                cataCell?.cataLabel.text = specialShotModel?.getTitle()
                cataCell?.cataImageView.hnk_setImageFromURL(NSURL(string: specialShotModel!.getPicUrl())!)
                cataCell?.priceLabel.text = "\(specialShotModel!.getPrice())元"
                cataCell?.cataIntroLabel.text = specialShotModel?.getIntro()
            }
            
            return cataCell!

        } else {
            
            let frontCell = self.mainTableView.dequeueReusableCellWithIdentifier("frontCell") as? FrontCell
            let tapRecognizer = UITapGestureRecognizer(target: self, action: "pushToPhotograher")
            frontCell!.userIDLabel.userInteractionEnabled = true
            
            
            if self.photographerIntroduceModel.count > 0 {
                let index = indexPath.section - 1
                frontCell?.locationLabel.text = self.photographerIntroduceModel[index].getLocation()
                frontCell?.timeLabel.text = self.photographerIntroduceModel[index].getPublishDate()
                frontCell?.userIDLabel.text = self.photographerIntroduceModel[index].getNickname()
                frontCell?.priceLabel.text = "￥\(self.photographerIntroduceModel[index].getPrice())"
                frontCell?.profileImageView.hnk_setImageFromURL(NSURL(string: self.photographerIntroduceModel[index].getAvatar())!)
                frontCell!.artImageView.hnk_setImageFromURL(NSURL(string: self.photographerIntroduceModel[index].getPicUrl())!)
                frontCell!.likeCountLabel.text = self.photographerIntroduceModel[index].getLikeCount()
                frontCell?.commentCountLabel.text = self.photographerIntroduceModel[index].getCommentCount()
                frontCell?.repostCountLabel.text = self.photographerIntroduceModel[index].getAppointmentCount()
            }
//            frontCell!.addGestureRecognizer(tapRecognizer)
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
        return photographerIntroduceModel.count > 0 ? photographerIntroduceModel.count + 1 : 3
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            let specialServiceDetailViewController = SpecialServiceDetailViewController(title: self.specialShotModel!.getIntro())
            specialServiceDetailViewController.specialShotModel = SpecialShotModel(picUrlValue: "", priceValue: "", titleValue: "", introValeu: "")
            specialServiceDetailViewController.specialShotModel = self.specialShotModel!
            specialServiceDetailViewController.imageUrlArray = ["http://111.13.47.169:8080/upload/image/custom/special2-xiangqing1.jpg","http://111.13.47.169:8080/upload/image/custom/special2-xiangqing2.jpg","http://111.13.47.169:8080/upload/image/custom/special2-xiangqing3.jpg"]
            self.navigationController?.pushViewController(specialServiceDetailViewController, animated: true)
        } else {
            let profileviewController =  UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("profileViewController") as! ProfileViewController
            profileviewController.photographerModel = PhotographerIntroduceModel(picUrlValue: "", priceValue: "", avatarValue: "", nicknameValue: "", publishDateValue: "", loactionValue: "", likeCountValue: "", photographerIdValue: "", commentCountValue: "", appointmentCountValue: "")
            profileviewController.photographerModel = self.photographerIntroduceModel[indexPath.section - 1]
            self.navigationController?.pushViewController(profileviewController, animated: true)
        }
        
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
        
        switch taskType {
            case TASK_TYPE_GET_HOME_PAGES:
                print("get home pages task success!")
                let sampleString: String! = extraData as! String
                self.imageUrl = sampleString.componentsSeparatedByString(",")
                self.mainTableView.reloadData()
                break
            case TASK_TYPE_GET_RECOMMENDED_PHOTOGRAPHER:
               
                if String(extraData) != nil {
                
                    let itemsString = JSON(extraData)[JSON_KEY_DATA][JSON_KEY_ITEMS].string
                    let itemsData = itemsString?.dataUsingEncoding(NSUTF8StringEncoding)
                
                    let jsonArr = try!NSJSONSerialization.JSONObjectWithData(itemsData!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
//
                
                    for item in jsonArr {
                        let picUrl = item.objectForKey(JSON_KEY_PIC_URL) as! String
                        let price = item.objectForKey(JSON_KEY_PRICE) as! String
                        let avatar = item.objectForKey(JSON_KEY_AVATAR) as! String
                        let nickname = item.objectForKey(JSON_KEY_NICKNAME) as! String
                        let publishDate = ToolKit.timeStampToString(item.objectForKey(JSON_KEY_PUBLISH_DATE) as! String)
                        let location = item.objectForKey(JSON_KEY_LOCATION) as! String
                        let likeCount = item.objectForKey(JSON_KEY_LIKE_COUNT) as! String
                        let photographerId = item.objectForKey(JSON_KEY_PHOTOGRAPHER_ID) as! String
                        let commentCount =  item.objectForKey(JSON_KEY_COMMENT_COUNT) as! String
                        let appointmentCount = item.objectForKey(JSON_KEY_APPOINTMENT_COUNT) as! String
                        
                        let photographerIntro: PhotographerIntroduceModel = PhotographerIntroduceModel(picUrlValue: picUrl, priceValue: price, avatarValue: avatar, nicknameValue: nickname, publishDateValue: publishDate, loactionValue: location, likeCountValue: likeCount, photographerIdValue: photographerId, commentCountValue: commentCount, appointmentCountValue: appointmentCount)
                      
                        self.photographerIntroduceModel.append(photographerIntro)
                    }
                    
                    
                
                    self.mainTableView.reloadData()
                }
                break
            case TASK_TYPE_GET_RECOMMENDED_SPECIAL_SHOT:
                specialShotModel = SpecialShotModel(picUrlValue: "", priceValue: "", titleValue: "", introValeu: "")
                specialShotModel = extraData as? SpecialShotModel
                self.mainTableView.reloadData()
                break
            default:
                break
        }
    }
    
    func onTaskError(taskType: Int!, errorCode: Int, extraData: AnyObject) {
        print("FrontViewController, onTaskError, handle please!")
    }
    
}

