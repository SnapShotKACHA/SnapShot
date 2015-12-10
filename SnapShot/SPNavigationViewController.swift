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
        SPNavigationBar = UINavigationBar(frame: CGRectMake(0, 0, CGFloat(SCREEN_WIDTH), 64))
        let titleShadow: NSShadow = NSShadow()
        titleShadow.shadowColor = UIColor(red: 218/255, green: 147/255, blue: 171/255, alpha: 1)
        titleShadow.shadowOffset = CGSizeMake(1, 1)
        SPNavigationBar?.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName:UIFont(name: "Heiti SC", size: 24.0)!, NSShadowAttributeName:titleShadow]
        
//        letButtonItem = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "cameraButtonAction")
        SPNavigationBar?.barTintColor = UIColor(red: 2/255, green: 191/255, blue: 141/255, alpha: 1)
        SPNavigationBar?.pushNavigationItem(initNavigationBarItem(), animated: false)
        SPNavigationBar?.tintColor = UIColor.whiteColor()
        self.view.addSubview(SPNavigationBar!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func removeNavigationBar() {
        self.SPNavigationBar?.removeFromSuperview()
    }
    
    func updateLeftBarItem(leftButton: UIBarButtonItem) {
        self.SPNavigationBarItem?.leftBarButtonItem = leftButton
    }
    
    func initNavigationBarItem() -> UINavigationItem {
        SPNavigationBarItem = UINavigationItem()
        SPNavigationBarItem!.title = "SnapShot"
        SPNavigationBarItem!.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "searchButtonAction")
        return SPNavigationBarItem!
    }
    
    
    
    func cameraButtonAction() {
        print("cameraButton is pressed!")
    }
    
    func searchButtonAction() {
        print("search Button is pressed!")
    }
    
    func popUpAction() {
        self.popToRootViewControllerAnimated(true)
        print("popUpAction")
    }
}