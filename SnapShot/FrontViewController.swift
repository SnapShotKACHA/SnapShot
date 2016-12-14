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
    
    override func viewWillAppear(_ animated: Bool) {
        if self.navBtn == nil {
        self.navBtn = ViewWidgest.addLeftButton("navigationButtonImage", imageAfter: "navigationButtonImage")
        self.navBtn?.addTarget(AppDelegate(), action: "leftViewShowAction", for: UIControlEvents.touchUpInside)
        self.navigationController?.navigationBar.addSubview(self.navBtn!)
        SnapShotTaskEngine.getInstance().doGetRecommendedSpecialShot("", longitude: "", latitude: "", engineProtocol: self)
        SnapShotTaskEngine.getInstance().doGetRecommendedPhotographerTask("13811245934", longitude: "", latitude: "", page: "0", step: "5", engineProtocol: self)
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.register(UINib(nibName: "FrontCell", bundle: nil), forCellReuseIdentifier: "frontCell")
        mainTableView.register(UINib(nibName: "CataCell", bundle: nil), forCellReuseIdentifier: "cataCell")
        mainTableView.separatorColor = UIColor.clear
        mainTableView.delegate = self
        mainTableView.dataSource = self
        initTableView()
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: "popToSearchViewController")
    }
    
    func initTableView() {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.frame = CGRect(x: SCREEN_WIDTH / 2 - 20, y: 84, width: 40, height: 40)
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

    override func viewWillDisappear(_ animated: Bool) {
        self.navBtn?.removeFromSuperview()
        self.navBtn = nil
        self.photographerIntroduceModel.removeAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  section == 0 {
            
            return 2
        }else {
            
            return 1
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return refreshViewHeight
        } else if indexPath.section == 0 && indexPath.row == 1 {
            return CATA_CELL_HEIGHT
        } else {
            return FRONT_CELL_HEIGHT
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        var cataCell: CataCell?
        
        if indexPath.section == 0 && indexPath.row == 0 {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
            cell.backgroundColor = UIColor.clear
            cell.contentView.backgroundColor = UIColor.clear
            cell.clipsToBounds = true
            return cell
        } else if indexPath.section == 0 && indexPath.row == 1 {
            cataCell = CataCell(style: UITableViewCellStyle.default, reuseIdentifier: "cataCell")
            cataCell = mainTableView.dequeueReusableCell(withIdentifier: "cataCell") as? CataCell
            cataCell?.cataLabel.text = "星球大战邀你来战"
            cataCell?.cataImageView.image = UIImage(named: "cataImageDefault")
            
            if specialShotModel != nil {
                cataCell?.cataLabel.text = specialShotModel?.getTitle()
                cataCell?.cataImageView.hnk_setImageFromURL(URL(string: specialShotModel!.getPicUrl())!)
                cataCell?.priceLabel.text = "\(specialShotModel!.getPrice())元"
                cataCell?.cataIntroLabel.text = specialShotModel?.getIntro()
            }
            
            return cataCell!

        } else {
            
            let frontCell = self.mainTableView.dequeueReusableCell(withIdentifier: "frontCell") as? FrontCell
            let tapRecognizer = UITapGestureRecognizer(target: self, action: "pushToPhotograher")
            frontCell!.userIDLabel.isUserInteractionEnabled = true
            
            
            if self.photographerIntroduceModel.count > 0 {
                let index = indexPath.section - 1
                frontCell?.locationLabel.text = self.photographerIntroduceModel[index].getLocation()
                frontCell?.timeLabel.text = self.photographerIntroduceModel[index].getPublishDate()
                frontCell?.userIDLabel.text = self.photographerIntroduceModel[index].getNickname()
                frontCell?.priceLabel.text = "￥\(self.photographerIntroduceModel[index].getPrice())"
                frontCell?.profileImageView.hnk_setImageFromURL(URL(string: self.photographerIntroduceModel[index].getAvatar())!)
                frontCell!.artImageView.hnk_setImageFromURL(URL(string: self.photographerIntroduceModel[index].getPicUrl())!)
                frontCell!.likeCountLabel.text = self.photographerIntroduceModel[index].getLikeCount()
                frontCell?.commentCountLabel.text = self.photographerIntroduceModel[index].getCommentCount()
                frontCell?.repostCountLabel.text = self.photographerIntroduceModel[index].getAppointmentCount()
            }
//            frontCell!.addGestureRecognizer(tapRecognizer)
            return frontCell!
        }
    }


    fileprivate func doReturnCell(_ row:Int) -> UITableViewCell {
        
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "frontCell") as! FrontCell
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "pushToPhotograher")
        cell.userIDLabel.isUserInteractionEnabled = true
        print(row)
        print(self.imageUrl)
        if self.imageUrl.count > 0 {
            cell.artImageView.hnk_setImageFromURL(URL(string: self.imageUrl[row])!)
        }
        cell.addGestureRecognizer(tapRecognizer)
        return cell
    }
    
    func pushToPhotograher() {
        let profileviewController =  UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(profileviewController, animated: true)
    }
    
    
    //=======================UITableViewDelegate 的实现===================================
    func numberOfSections(in tableView: UITableView) -> Int {
        return photographerIntroduceModel.count > 0 ? photographerIntroduceModel.count + 1 : 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            let specialServiceDetailViewController = SpecialServiceDetailViewController(title: self.specialShotModel!.getIntro())
            specialServiceDetailViewController.specialShotModel = SpecialShotModel(picUrlValue: "", priceValue: "", titleValue: "", introValeu: "")
            specialServiceDetailViewController.specialShotModel = self.specialShotModel!
            specialServiceDetailViewController.imageUrlArray = ["http://111.13.47.169:8080/upload/image/custom/special2-xiangqing1.jpg","http://111.13.47.169:8080/upload/image/custom/special2-xiangqing2.jpg","http://111.13.47.169:8080/upload/image/custom/special2-xiangqing3.jpg"]
            self.navigationController?.pushViewController(specialServiceDetailViewController, animated: true)
        } else {
            let profileviewController =  UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
            profileviewController.photographerModel = PhotographerIntroduceModel(picUrlValue: "", priceValue: "", avatarValue: "", nicknameValue: "", publishDateValue: "", loactionValue: "", likeCountValue: "", photographerIdValue: "", commentCountValue: "", appointmentCountValue: "")
            profileviewController.photographerModel = self.photographerIntroduceModel[indexPath.section - 1]
            self.navigationController?.pushViewController(profileviewController, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
                return 0
        }
        
        return CGFloat(SECTION_HEIGHT)
    }
    
    func SlideScrollViewDidClicked(_ index: Int) {
        print(index)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func onTaskSuccess(_ taskType: Int!, successCode: Int, extraData: AnyObject) {
        print("FrontViewController, onTaskSuccess")
        
        switch taskType {
            case TASK_TYPE_GET_HOME_PAGES:
                print("get home pages task success!")
                let sampleString: String! = extraData as! String
                self.imageUrl = sampleString.components(separatedBy: ",")
                self.mainTableView.reloadData()
                break
            case TASK_TYPE_GET_RECOMMENDED_PHOTOGRAPHER:
               
                if String(extraData) != nil {
                
                    let itemsString = JSON(extraData)[JSON_KEY_DATA][JSON_KEY_ITEMS].string
                    let itemsData = itemsString?.data(using: String.Encoding.utf8)
                
                    let jsonArr = try!JSONSerialization.jsonObject(with: itemsData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
//
                
                    for item in jsonArr {
                        let picUrl = item.object(forKey: JSON_KEY_PIC_URL) as! String
                        let price = item.object(forKey: JSON_KEY_PRICE) as! String
                        let avatar = item.object(forKey: JSON_KEY_AVATAR) as! String
                        let nickname = item.object(forKey: JSON_KEY_NICKNAME) as! String
                        let publishDate = ToolKit.timeStampToString(item.object(forKey: JSON_KEY_PUBLISH_DATE) as! String)
                        let location = item.object(forKey: JSON_KEY_LOCATION) as! String
                        let likeCount = item.object(forKey: JSON_KEY_LIKE_COUNT) as! String
                        let photographerId = item.object(forKey: JSON_KEY_PHOTOGRAPHER_ID) as! String
                        let commentCount =  item.object(forKey: JSON_KEY_COMMENT_COUNT) as! String
                        let appointmentCount = item.object(forKey: JSON_KEY_APPOINTMENT_COUNT) as! String
                        
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
    
    func onTaskError(_ taskType: Int!, errorCode: Int, extraData: AnyObject) {
        print("FrontViewController, onTaskError, handle please!")
    }
    
}

