//
//  SpecialServiceDetailsViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 20/01/2016.
//  Copyright © 2016 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class SpecialServiceDetailViewController: BasicViewController, UITableViewDelegate, UITableViewDataSource {
    var specialServiceDetailTableView: UITableView!
    var groupTitle: String?
    
    init(title:String) {
        super.init(nibName: nil, bundle: nil)
        self.groupTitle = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.title = groupTitle
        self.specialServiceDetailTableView = UITableView(frame: CGRectMake(0, 0, CGFloat(SCREEN_WIDTH), CGFloat(SCREEN_HEIGHT)))
        self.specialServiceDetailTableView.registerNib(UINib(nibName: "LowerCell", bundle: nil), forCellReuseIdentifier: "lowerCell")
        self.specialServiceDetailTableView.scrollEnabled = false
        self.specialServiceDetailTableView.delegate = self
        self.specialServiceDetailTableView.dataSource = self
        self.view.addSubview(self.specialServiceDetailTableView!)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return DETAIL_CELL_HEIGHT
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let identifier = "upperCell"
            let upperCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            upperCell.frame = CGRectMake(0, 44, CGFloat(SCREEN_WIDTH), DETAIL_CELL_HEIGHT)
            upperCell.backgroundColor = UIColor.whiteColor()
            let slideRect = CGRectMake(10, 10, CGFloat(SCREEN_WIDTH - 20), 200)
            let slideScrollView = SlidScrollView(frame: slideRect)
            
            slideScrollView.initWithFrameRect(slideRect,
                picAddressArray: ["http://img.article.pchome.net/game/00/25/32/06/248_131117202025_1.jpg", "http://img.article.pchome.net/game/00/25/32/06/248_131117202039_1.jpg","http://img.article.pchome.net/game/00/25/32/06/248_131117202057_1.jpg"],
                titleArray: ["巫妖王","尤迪安","冰封王座"])
            let priceLabel = UILabel(frame: CGRect(x: 10, y: DETAIL_CELL_HEIGHT * 0.6 + 50, width: 80, height: 30))
            priceLabel.text = "￥100"
            priceLabel.font = UIFont(name: HEITI, size: 27)
            priceLabel.textColor = SP_BLUE_COLOR
            
            let appointButton = UIButton(frame: CGRect(x: SCREEN_WIDTH/2 + 55, y: DETAIL_CELL_HEIGHT * 0.6 + 45, width: 120, height: 40))
            appointButton.backgroundColor = SP_BLUE_COLOR
            appointButton.setTitle("预约", forState:  UIControlState.Normal)
            appointButton.titleLabel?.textColor = UIColor.whiteColor()
            
            upperCell.addSubview(appointButton)
            upperCell.addSubview(priceLabel)
            upperCell.addSubview(slideScrollView)
            upperCell.selectionStyle = UITableViewCellSelectionStyle.None
            return upperCell
        } else {
            let lowerCell = self.specialServiceDetailTableView.dequeueReusableCellWithIdentifier("lowerCell") as? LowerCell
            lowerCell?.lowerCellTimeLabel.text = "与摄影师沟通"
            lowerCell?.lowerCellLocationLabel.text = "与摄影师沟通"
            lowerCell?.lowerCellServiceLabel.text = ">20张拍摄，5张精修"
            lowerCell?.lowerCellMembersLabel.text = "1组"
            lowerCell?.lowerCellPhotographerLabel.text = "2人"
            lowerCell?.lowerCellnfoLabel.text = "北京奥林匹克森林公园团体*********"
            lowerCell?.variableLabel.text = "造型"
            lowerCell?.selectionStyle = UITableViewCellSelectionStyle.None
            lowerCell?.addSubview(ViewWidgest.getVerticalSeporatorImageView(SCREEN_WIDTH/3, y: SCREEN_HEIGHT - 45))
            lowerCell?.addSubview(ViewWidgest.getVerticalSeporatorImageView((SCREEN_WIDTH * 2)/3, y: SCREEN_HEIGHT - 45))
            return lowerCell!
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

}