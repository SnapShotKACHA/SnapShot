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
    var specialShotModel: SpecialShotModel?
    var imageUrlArray: [String] = []
    init(title:String) {
        super.init(nibName: nil, bundle: nil)
        self.groupTitle = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.specialShotModel != nil {
            self.specialServiceDetailTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        self.title = groupTitle
        self.specialServiceDetailTableView = UITableView(frame: CGRect(x: 0, y: 0, width: CGFloat(SCREEN_WIDTH), height: CGFloat(SCREEN_HEIGHT)))
        self.specialServiceDetailTableView.register(UINib(nibName: "LowerCell", bundle: nil), forCellReuseIdentifier: "lowerCell")
        self.specialServiceDetailTableView.isScrollEnabled = false
        self.specialServiceDetailTableView.delegate = self
        self.specialServiceDetailTableView.dataSource = self
        self.view.addSubview(self.specialServiceDetailTableView!)
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
            let priceLabel = UILabel(frame: CGRect(x: 10, y: DETAIL_CELL_HEIGHT * 0.6 + 50, width: 80, height: 30))
            priceLabel.text = "￥100"
            priceLabel.font = UIFont(name: HEITI, size: 27)
            priceLabel.textColor = SP_BLUE_COLOR
            
            let appointButton = UIButton(frame: CGRect(x: SCREEN_WIDTH/2 + 45, y: DETAIL_CELL_HEIGHT * 0.6 + 45, width: 120, height: 40))
            appointButton.backgroundColor = SP_BLUE_COLOR
            appointButton.setTitle("预约", for:  UIControlState())
            appointButton.titleLabel?.textColor = UIColor.white
            
            upperCell.addSubview(appointButton)
            upperCell.addSubview(priceLabel)
            upperCell.addSubview(slideScrollView)
            upperCell.selectionStyle = UITableViewCellSelectionStyle.none
            
            if self.specialShotModel != nil {
                priceLabel.text = "￥\(self.specialShotModel!.getPrice())"
            }
            
            return upperCell
        } else {
            let lowerCell = self.specialServiceDetailTableView.dequeueReusableCell(withIdentifier: "lowerCell") as? LowerCell
            lowerCell?.lowerCellTimeLabel.text = "与摄影师沟通"
            lowerCell?.lowerCellLocationLabel.text = "与摄影师沟通"
            lowerCell?.lowerCellServiceLabel.text = ">20张拍摄，5张精修"
            lowerCell?.lowerCellMembersLabel.text = "1组"
            lowerCell?.lowerCellPhotographerLabel.text = "2人"
            lowerCell?.lowerCellnfoLabel.text = "北京奥林匹克森林公园团体*********"
            lowerCell?.variableLabel.text = "造型"
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
