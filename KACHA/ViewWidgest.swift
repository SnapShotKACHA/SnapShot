//
//  ViewWidgest.swift
//  SnapShot
//
//  Created by Jacob Li on 28/10/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class ViewWidgest{
    static func addLeftButton(imageBefore:String, imageAfter:String) -> UIButton {
        let leftBtn: UIButton = UIButton(frame: CGRect(x: 7, y: 7, width: 30, height: 30))
        leftBtn.contentMode = UIViewContentMode.ScaleAspectFit
        leftBtn.setImage(UIImage(named: imageBefore), forState: UIControlState.Normal)
        leftBtn.setImage(UIImage(named: imageAfter), forState: UIControlState.Highlighted)
        return leftBtn
    }
    
    static func addLeftButton(buttonName:String) -> UIButton {
        let leftBtn: UIButton = UIButton(frame: CGRect(x: 2, y: 5, width: 60, height: 30))
        leftBtn.setTitle(buttonName, forState:  UIControlState.Normal)
        return leftBtn
    }
    
    static func addRightButton(imageBefore:String, imageAfter:String) -> UIButton {
        let rightBtn: UIButton = UIButton(frame: CGRect(x: Int(SCREEN_WIDTH - 48), y: 7, width: 30, height: 30))
        rightBtn.setImage(UIImage(named: imageBefore), forState: UIControlState.Normal)
        rightBtn.setImage(UIImage(named: imageAfter), forState: UIControlState.Highlighted)
        return rightBtn
    }
    
    static func addRightButton(buttonName:String) -> UIButton {
        let rightBtn: UIButton = UIButton(frame: CGRect(x: Int(SCREEN_WIDTH - 62), y: 7, width: 60, height: 30))
        rightBtn.setTitle(buttonName, forState: UIControlState.Normal)
        return rightBtn
    }
    
    static func backToRoot(navgationViewController: UINavigationController) {
        navgationViewController.popToRootViewControllerAnimated(true)
    }
    
    static func navigatiobBarButtomButton(ButtonArray:[UIButton], titleArray:[String], targetArrary:[Selector], view:UIView) {
        
//        navigationController!.navigationBar.frame = CGRectMake(0, 20, CGFloat(SCREEN_WIDTH), 83)
        
        let buttonView = UIView(frame: CGRect(x: 0, y: 64, width: CGFloat(SCREEN_WIDTH), height: 40))
        buttonView.backgroundColor = UIColor.blackColor()
       
        
        // 画按钮
        for var i = 0; i < 3; i++ {
            ButtonArray[i].frame = CGRect(x: Double((SCREEN_WIDTH/3) * CGFloat(i)), y: 0, width: Double(SCREEN_WIDTH/3), height: 40)
            ButtonArray[i].setTitle(titleArray[i], forState: UIControlState.Normal)
            ButtonArray[i].setTitleColor(TEXT_COLOR_GREY, forState: UIControlState.Normal)
            ButtonArray[i].setTitleColor(TEXT_COLOR_LIGHT_GREY, forState: UIControlState.Highlighted)
            ButtonArray[i].titleLabel?.font = UIFont.systemFontOfSize(14)
            ButtonArray[i].backgroundColor = UIColor.whiteColor()
            ButtonArray[i].addTarget(self, action: targetArrary[i], forControlEvents: UIControlEvents.TouchUpInside)
            buttonView.addSubview(ButtonArray[i])
        }
        
        // 画分割线
        for var i = 0; i < 2; i++ {
            let verticalShortLine: UIImageView = UIImageView(frame: CGRect(x: Double((SCREEN_WIDTH/3) * CGFloat(i + 1)), y: 0, width: 0.5, height: 32))
            verticalShortLine.image = UIImage(named: "verticalLineImage")
            verticalShortLine.tag = 100+i
            buttonView.addSubview(verticalShortLine)
        }
        
         view.addSubview(buttonView)
    }
    
    static func recoverNavigationBar(viewsArrary:[UIView], navigationController:UINavigationController) {
        
        if viewsArrary.count > 0 {
            for view in viewsArrary {
                view.removeFromSuperview()
            }
        }
        
        if navigationController.isKindOfClass(UINavigationController) {
            navigationController.navigationBar.frame = CGRectMake(0, 20, CGFloat(SCREEN_WIDTH), 44)
            navigationController.navigationBar.viewWithTag(100)?.removeFromSuperview()
            navigationController.navigationBar.viewWithTag(101)?.removeFromSuperview()
        }
    }
    
    static func getHorizontalSeporatorImageView (y: CGFloat) -> UIImageView  {
        let seporator = UIImageView(image: UIImage(named: "seperateLineImage"))
        seporator.frame = CGRectMake(20, y, SCREEN_WIDTH - 40, 1)
        return seporator
    }
    
    static func getVerticalSeporatorImageView (x:CGFloat, y: CGFloat) -> UIImageView  {
        let seporator = UIImageView(image: UIImage(named: "verticalLineImage"))
        seporator.frame = CGRectMake(x, y, 1, 40)
        return seporator
    }
    
    static func displayAlert(title:String, message:String, actions:[UIAlertAction]) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        return alert
    }
}