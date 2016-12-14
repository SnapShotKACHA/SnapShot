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
        self.contentSize = CGSize(width: SCREEN_WIDTH, height: 700)
        let nibCommentCell = UINib(nibName: "CommentCell", bundle: nil)
        self.register(nibCommentCell, forCellReuseIdentifier: "commentCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //==================UITableViewDataSource====================================================//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = (self.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentCell)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //==================UITableViewDelegate===========================================================//
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionNumber == 0 ? 1: self.sectionNumber
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return COMMENT_CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 90
        } else {
            return 0
        }
    }

}
