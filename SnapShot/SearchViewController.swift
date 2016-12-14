//
//  SearchViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 30/10/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var SVsearchBar: UISearchBar?
    var locationBtn: UIButton?
    var cancelBtn: UIButton?
    var searchBtn: UIButton?
    var displayController: UISearchController?
    var navBtn: UIButton?
    var priceSortButton: UIButton?
    var appointSortButton: UIButton?
    var rateSortButton: UIButton?
    
    @IBOutlet weak var SVTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSearchBar()
        
        let nib = UINib(nibName: "CardCell", bundle: nil)
        if self.SVTableView != nil {
            SVTableView!.register(nib, forCellReuseIdentifier: "cardCell")
            
            SVTableView!.delegate = self
            SVTableView!.dataSource = self
        }
        
        self.priceSortButton = UIButton()
        self.appointSortButton = UIButton()
        self.rateSortButton = UIButton()
        self.initSortButtons([self.priceSortButton!,self.appointSortButton!,self.rateSortButton!], titleArray: ["价格优先","预约量优先","评级优先"], targetArrary: [#selector(SearchViewController.priceSortAction) , #selector(SearchViewController.appointSortAction), #selector(SearchViewController.rateSortAction)])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.SVsearchBar?.removeFromSuperview()
        self.locationBtn?.removeFromSuperview()
        self.cancelBtn?.removeFromSuperview()
        ViewWidgest.recoverNavigationBar([self.SVsearchBar!, self.locationBtn!, self.cancelBtn!, self.priceSortButton!, self.appointSortButton!,self.rateSortButton!], navigationController: self.navigationController!)
    }
    
    // 初始化导航栏
    func initSearchBar() {
        self.navigationItem.hidesBackButton = true
        self.SVsearchBar = UISearchBar(frame: CGRect(x: 60, y: 0, width: Int(SCREEN_WIDTH - 120), height: 40))
        self.SVsearchBar?.placeholder = "萌娃外拍"
        
        self.SVsearchBar?.showsSearchResultsButton = true
        self.SVsearchBar?.delegate = self
        self.locationBtn = ViewWidgest.addLeftButton("北京")
        self.cancelBtn = ViewWidgest.addRightButton("取消")
        
        locationBtn!.addTarget(self, action: #selector(SearchViewController.locationBtnAction), for: UIControlEvents.touchUpInside)
        cancelBtn!.addTarget(self, action: #selector(SearchViewController.cancelBtnAction), for: UIControlEvents.touchUpInside)
        
        self.navigationController?.navigationBar.addSubview(self.SVsearchBar!)
        self.navigationController?.navigationBar.addSubview(self.locationBtn!)
        self.navigationController?.navigationBar.addSubview(self.cancelBtn!)
        
        
        self.displayController = UISearchController(searchResultsController: self)
        self.displayController?.delegate = self
    }
    
    // 初始化排序按钮
    func initSortButtons( _ ButtonArray:[UIButton], titleArray:[String], targetArrary:[Selector]) {
        // 画按钮
        for i in 0 ..< 3 {
            ButtonArray[i].frame = CGRect(x: Double((SCREEN_WIDTH/3) * CGFloat(i)), y: 44, width: Double(SCREEN_WIDTH/3), height: 40)
            ButtonArray[i].setTitle(titleArray[i], for: UIControlState())
            ButtonArray[i].setTitleColor(TEXT_COLOR_GREY, for: UIControlState())
            ButtonArray[i].setTitleColor(TEXT_COLOR_LIGHT_GREY, for: UIControlState.highlighted)
            ButtonArray[i].titleLabel?.font = UIFont.systemFont(ofSize: 14)
            ButtonArray[i].backgroundColor = UIColor.white
            ButtonArray[i].addTarget(self, action: targetArrary[i], for: UIControlEvents.touchUpInside)
            self.navigationController?.navigationBar.addSubview(ButtonArray[i])
            
        }
        
        // 画分割线
        for i in 0 ..< 2 {
            let verticalShortLine: UIImageView = UIImageView(frame: CGRect(x: Double((SCREEN_WIDTH/3) * CGFloat(i + 1)), y: 49, width: 0.5, height: 32))
            verticalShortLine.image = UIImage(named: "verticalLineImage")
            verticalShortLine.tag = 100+i
            self.navigationController?.navigationBar.addSubview(verticalShortLine)
        }

    }

    
    func priceSortAction() {
        print("priceSort")
    }
    
    func appointSortAction() {
        print("appointSort")
    }
    
    func rateSortAction() {
        print("rateSort")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.cancelBtn?.removeFromSuperview()
        self.searchBtn = ViewWidgest.addRightButton("搜索")
        self.searchBtn?.addTarget(self, action: #selector(SearchViewController.searchBtnAction), for: UIControlEvents.touchUpInside)
        self.navigationController?.navigationBar.addSubview(self.searchBtn!)
    }

    
    
    //---------------------UISearchBarDelegate-------------//
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchBtn?.removeFromSuperview()
        return true
    }
    

    func locationBtnAction() {
    
    }
    
    func cancelBtnAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func searchBtnAction() {
        self.searchBtn?.removeFromSuperview()
        self.navigationController?.navigationBar.addSubview(self.cancelBtn!)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    //--------------------UITableViewDataSource-----------//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return CGFloat(TABLE_CELL_HEIGHT)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        
        let tmp = tableView.dequeueReusableCell(withIdentifier: "cardCell")
        
        if tmp == nil {
            cell = CardCell(style: UITableViewCellStyle.default, reuseIdentifier: "cardCell")
        } else {
            cell = tmp!
        }
        
        _ = cell as! CardCell
        
        if indexPath.section == 0 {
            cell = doReturnCell(indexPath.row - 1)
        } else {
            cell = self.doReturnCell(indexPath.row)
        }
        return cell

    }
    
    
    fileprivate func doReturnCell(_ row:Int) -> UITableViewCell {
        
        let cell = SVTableView.dequeueReusableCell(withIdentifier: "cardCell") as! CardCell
        cell.photographerIDLabel.text = "安琪胡桃夹子"
        cell.priceLabel.text = "￥350"
        cell.setRateImages(3)
        cell.displayImage.image = UIImage(named: "cellDefaultImage")
        
        
        
        return cell
    }
    
    
    //=======================UITableViewDelegate 的实现===================================
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        }
        
        return CGFloat(SECTION_HEIGHT)
    }
    
    func SlideScrollViewDidClicked(_ index: Int) {
        print(index)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.SVsearchBar?.resignFirstResponder()
        self.searchBtn?.resignFirstResponder()
    }
}
