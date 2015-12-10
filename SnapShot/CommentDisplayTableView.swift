//
//  CommentDisplayTableView.swift
//  SnapShot
//
//  Created by Jacob Li on 30/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class CommentDisplayTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    var sectionNumber:Int = 0
    init(frame: CGRect, style: UITableViewStyle, numberOfSection:Int) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.delegate = self
        self.sectionNumber = numberOfSection
        self.contentSize = CGSize(width: SCREEN_WIDTH, height: 600)
        let nibCommentCell = UINib(nibName: "CommentCell", bundle: nil)
        self.registerNib(nibCommentCell, forCellReuseIdentifier: "commentCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //==================UITableViewDataSource====================================================//
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = (self.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as? CommentCell)!
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //==================UITableViewDelegate===========================================================//
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionNumber == 0 ? 1: self.sectionNumber
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return COMMENT_CELL_HEIGHT
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

}