//
//  ArtsDisplayTableView.swift
//  SnapShot
//
//  Created by Jacob Li on 30/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class ArtsDisplayTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    var sectionNumber:Int = 0
    init(frame: CGRect, style: UITableViewStyle, numberOfSection:Int) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.delegate = self
        self.sectionNumber = numberOfSection
        self.contentSize = CGSize(width: SCREEN_WIDTH, height: 700)
        let nibArtCell = UINib(nibName: "ArtCell", bundle: nil)
        self.registerNib(nibArtCell, forCellReuseIdentifier: "artCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //==================UITableViewDataSource====================================================//
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell: ArtCell = (self.dequeueReusableCellWithIdentifier("artCell", forIndexPath: indexPath) as? ArtCell)!
            cell.artImageView = UIImageView(image: UIImage(named: "frontCellImageDefault1"))
            return cell
        } else {
            let cell: ArtCell = (self.dequeueReusableCellWithIdentifier("artCell", forIndexPath: indexPath) as? ArtCell)!
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    //==================UITableViewDelegate===========================================================//
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionNumber == 0 ? 1: self.sectionNumber
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 90
        } else {
            return 0
        }
    }

}