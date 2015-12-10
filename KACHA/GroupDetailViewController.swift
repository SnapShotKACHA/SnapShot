//
//  GroupDetailViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 17/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class GroupDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var groupDetailTableView: UITableView!
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
        self.groupDetailTableView = UITableView(frame: CGRectMake(0, 0, CGFloat(SCREEN_WIDTH), CGFloat(SCREEN_HEIGHT)))
        self.groupDetailTableView.registerNib(UINib(nibName: "LowerCell", bundle: nil), forCellReuseIdentifier: "lowerCell")
        self.groupDetailTableView.scrollEnabled = false
        self.groupDetailTableView.delegate = self
        self.groupDetailTableView.dataSource = self
        self.view.addSubview(self.groupDetailTableView!)
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
//            var upperCell: UITableViewCell = groupDetailTableView.dequeueReusableCellWithIdentifier(identifier)!
            let upperCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            upperCell.frame = CGRectMake(0, 44, CGFloat(SCREEN_WIDTH), DETAIL_CELL_HEIGHT)
            upperCell.backgroundColor = UIColor.whiteColor()
            let slideRect = CGRectMake(10, 10, CGFloat(SCREEN_WIDTH - 20), DETAIL_CELL_HEIGHT * 0.6 + 5)
            let slideScrollView = SlidScrollView(frame: slideRect)
            
            slideScrollView.initWithFrameRect(slideRect,
                            picAddressArray: ["http://img.article.pchome.net/game/00/25/32/06/248_131117202025_1.jpg", "http://img.article.pchome.net/game/00/25/32/06/248_131117202039_1.jpg","http://img.article.pchome.net/game/00/25/32/06/248_131117202057_1.jpg"],
                            titleArray: ["巫妖王","尤迪安","冰封王座"])
            let priceLabel = UILabel(frame: CGRect(x: 10, y: DETAIL_CELL_HEIGHT * 0.6 + 30, width: 80, height: 30))
            priceLabel.text = "￥350"
            priceLabel.font = UIFont(name: "Heiti SC", size: 27)
            priceLabel.textColor = SP_BLUE_COLOR
            
            let appointButton = UIButton(frame: CGRect(x: SCREEN_WIDTH/2 + 45, y: DETAIL_CELL_HEIGHT * 0.6 + 25, width: 120, height: 40))
            appointButton.backgroundColor = SP_BLUE_COLOR
            appointButton.setTitle("报名", forState:  UIControlState.Normal)
            appointButton.titleLabel?.textColor = UIColor.whiteColor()
            
            let occupiedLabel = UILabel(frame: CGRect(x: 40, y: Int(DETAIL_CELL_HEIGHT * 0.6 + 85), width: 150, height: 30))
            let occupiedNum = 4
            occupiedLabel.text = "已有\(occupiedNum)个家庭报名"
            occupiedLabel.textColor = TEXT_COLOR_GREY
            occupiedLabel.font = UIFont(name: "Heiti SC", size: 15)
            let vacancyLabel = UILabel(frame: CGRect(x: Int(SCREEN_WIDTH/2 + 40), y: Int(DETAIL_CELL_HEIGHT * 0.6 + 85), width: 150, height: 30))
            let vacancyNum = 1
            vacancyLabel.text = "剩余\(vacancyNum)个家庭名额"
            vacancyLabel.textColor = TEXT_COLOR_GREY
            vacancyLabel.font = UIFont(name: "Heiti SC", size: 15)
            
            
            
            upperCell.addSubview(ViewWidgest.getHorizontalSeporatorImageView(DETAIL_CELL_HEIGHT * 0.6 + 75))
            upperCell.addSubview(ViewWidgest.getVerticalSeporatorImageView(SCREEN_WIDTH/2, y: DETAIL_CELL_HEIGHT * 0.6 + 80))
            upperCell.addSubview(appointButton)
            upperCell.addSubview(priceLabel)
            upperCell.addSubview(occupiedLabel)
            upperCell.addSubview(vacancyLabel)
            upperCell.addSubview(slideScrollView)
            upperCell.selectionStyle = UITableViewCellSelectionStyle.None
            return upperCell
        } else {
            let lowerCell = self.groupDetailTableView.dequeueReusableCellWithIdentifier("lowerCell") as? LowerCell
            lowerCell?.lowerCellTimeLabel.text = "2015年11月6日14:00-18:00"
            lowerCell?.lowerCellLocationLabel.text = "北京奥林匹克森林公园"
            lowerCell?.lowerCellServiceLabel.text = ">60张拍摄，30张精修"
            lowerCell?.lowerCellMembersLabel.text = "3-5个家庭"
            lowerCell?.lowerCellPhotographerLabel.text = "2人"
            lowerCell?.lowerCellnfoLabel.text = "北京奥林匹克森林公园团体*********"
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
