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
    var imageUrlArray: [String] = []
    init(title:String) {
        super.init(nibName: nil, bundle: nil)
        self.groupTitle = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.title = groupTitle
        self.groupDetailTableView = UITableView(frame: CGRect(x: 0, y: 0, width: CGFloat(SCREEN_WIDTH), height: CGFloat(SCREEN_HEIGHT)))
        self.groupDetailTableView.register(UINib(nibName: "LowerCell", bundle: nil), forCellReuseIdentifier: "lowerCell")
        self.groupDetailTableView.isScrollEnabled = false
        self.groupDetailTableView.delegate = self
        self.groupDetailTableView.dataSource = self
        self.view.addSubview(self.groupDetailTableView!)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DETAIL_CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let identifier = "upperCell"
            let upperCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
            upperCell.frame = CGRect(x: 0, y: 44, width: CGFloat(SCREEN_WIDTH), height: DETAIL_CELL_HEIGHT)
            upperCell.backgroundColor = UIColor.white
            let slideRect = CGRect(x: 10, y: 10, width: CGFloat(SCREEN_WIDTH - 20), height: DETAIL_CELL_HEIGHT * 0.6 + 5)
            let slideScrollView = SlidScrollView(frame: slideRect)
            
            slideScrollView.initWithFrameRect(slideRect,
                            picAddressArray: imageUrlArray,
                            titleArray: ["","",""])
            let priceLabel = UILabel(frame: CGRect(x: 10, y: DETAIL_CELL_HEIGHT * 0.6 + 30, width: 80, height: 30))
            priceLabel.text = "￥350"
            priceLabel.font = UIFont(name: HEITI, size: 27)
            priceLabel.textColor = SP_BLUE_COLOR
            
            let appointButton = UIButton(frame: CGRect(x: SCREEN_WIDTH/2 + 45, y: DETAIL_CELL_HEIGHT * 0.6 + 25, width: 120, height: 40))
            appointButton.backgroundColor = SP_BLUE_COLOR
            appointButton.setTitle("报名", for:  UIControlState())
            appointButton.titleLabel?.textColor = UIColor.white
            
            let occupiedLabel = UILabel(frame: CGRect(x: 40, y: Int(DETAIL_CELL_HEIGHT * 0.6 + 85), width: 150, height: 30))
            let occupiedNum = 4
            occupiedLabel.text = "已有\(occupiedNum)个家庭报名"
            occupiedLabel.textColor = TEXT_COLOR_GREY
            occupiedLabel.font = UIFont(name: HEITI, size: 15)
            let vacancyLabel = UILabel(frame: CGRect(x: Int(SCREEN_WIDTH/2 + 40), y: Int(DETAIL_CELL_HEIGHT * 0.6 + 85), width: 150, height: 30))
            let vacancyNum = 1
            vacancyLabel.text = "剩余\(vacancyNum)个家庭名额"
            vacancyLabel.textColor = TEXT_COLOR_GREY
            vacancyLabel.font = UIFont(name: HEITI, size: 15)
            
            
            
            upperCell.addSubview(ViewWidgest.getHorizontalSeporatorImageView(DETAIL_CELL_HEIGHT * 0.6 + 75))
            upperCell.addSubview(ViewWidgest.getVerticalSeporatorImageView(SCREEN_WIDTH/2, y: DETAIL_CELL_HEIGHT * 0.6 + 80))
            upperCell.addSubview(appointButton)
            upperCell.addSubview(priceLabel)
            upperCell.addSubview(occupiedLabel)
            upperCell.addSubview(vacancyLabel)
            upperCell.addSubview(slideScrollView)
            upperCell.selectionStyle = UITableViewCellSelectionStyle.none
            return upperCell
        } else {
            let lowerCell = self.groupDetailTableView.dequeueReusableCell(withIdentifier: "lowerCell") as? LowerCell
            lowerCell?.lowerCellTimeLabel.text = "2015年11月6日14:00-18:00"
            lowerCell?.lowerCellLocationLabel.text = "北京奥林匹克森林公园"
            lowerCell?.lowerCellServiceLabel.text = ">60张拍摄，30张精修"
            lowerCell?.lowerCellMembersLabel.text = "3-5个家庭"
            lowerCell?.lowerCellPhotographerLabel.text = "2人"
            lowerCell?.lowerCellnfoLabel.text = "北京奥林匹克森林公园团体*********"
            lowerCell?.selectionStyle = UITableViewCellSelectionStyle.none
            lowerCell?.addSubview(ViewWidgest.getVerticalSeporatorImageView(SCREEN_WIDTH/3, y: SCREEN_HEIGHT - 45))
            lowerCell?.addSubview(ViewWidgest.getVerticalSeporatorImageView((SCREEN_WIDTH * 2)/3, y: SCREEN_HEIGHT - 45))
            return lowerCell!
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}
