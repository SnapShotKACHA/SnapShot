//
//  SPNavigationViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 19/10/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

protocol SPNavigationBarDelegate {
    func addBackButton()
}

class SPNavigationViewController: UINavigationController {
    
    var SPNavigationBar:UINavigationBar?
    var SPNavigationBarItem: UINavigationItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SPNavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: CGFloat(SCREEN_WIDTH), height: 64))
        let titleShadow: NSShadow = NSShadow()
        titleShadow.shadowColor = UIColor(red: 218/255, green: 147/255, blue: 171/255, alpha: 1)
        titleShadow.shadowOffset = CGSize(width: 1, height: 1)
        SPNavigationBar?.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:UIFont(name: "Heiti SC", size: 24.0)!, NSShadowAttributeName:titleShadow]
        
//        letButtonItem = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "cameraButtonAction")
        SPNavigationBar?.barTintColor = UIColor(red: 2/255, green: 191/255, blue: 141/255, alpha: 1)
        SPNavigationBar?.pushItem(initNavigationBarItem(), animated: false)
        SPNavigationBar?.tintColor = UIColor.white
        self.view.addSubview(SPNavigationBar!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func removeNavigationBar() {
        self.SPNavigationBar?.removeFromSuperview()
    }
    
    func updateLeftBarItem(_ leftButton: UIBarButtonItem) {
        self.SPNavigationBarItem?.leftBarButtonItem = leftButton
    }
    
    func initNavigationBarItem() -> UINavigationItem {
        SPNavigationBarItem = UINavigationItem()
        SPNavigationBarItem!.title = "SnapShot"
        SPNavigationBarItem!.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(SPNavigationViewController.searchButtonAction))
        return SPNavigationBarItem!
    }
    
    
    
    func cameraButtonAction() {
        print("cameraButton is pressed!")
    }
    
    func searchButtonAction() {
        print("search Button is pressed!")
    }
    
    func popUpAction() {
        self.popToRootViewController(animated: true)
        print("popUpAction")
    }
}
