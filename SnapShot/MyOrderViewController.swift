//
//  MyOrderViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 04/12/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class MyOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var myOrderTableView: UITableView?
    
    init(title:String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.title = "我的订单"
        self.myOrderTableView = UITableView(frame: CGRect(x: 0, y: 44, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 44), style: .plain)
        self.myOrderTableView?.delegate = self
        self.myOrderTableView?.dataSource = self
        let nibOrderCell = UINib(nibName: "OrderCell", bundle: nil)
        self.myOrderTableView?.register(nibOrderCell, forCellReuseIdentifier: "orderCell")
        self.view.addSubview(self.myOrderTableView!)
    }
    
    //==================UITableViewDataSource====================================================//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = (self.myOrderTableView!.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as? OrderCell)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //==================UITableViewDelegate===========================================================//
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return VALUE_CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
