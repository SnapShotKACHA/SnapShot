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
    static func addLeftButton(_ imageBefore:String, imageAfter:String) -> UIButton {
        let leftBtn: UIButton = UIButton(frame: CGRect(x: 7, y: 7, width: 30, height: 30))
        leftBtn.contentMode = UIViewContentMode.scaleAspectFit
        leftBtn.setImage(UIImage(named: imageBefore), for: UIControlState())
        leftBtn.setImage(UIImage(named: imageAfter), for: UIControlState.highlighted)
        return leftBtn
    }
    
    static func addLeftButton(_ buttonName:String) -> UIButton {
        let leftBtn: UIButton = UIButton(frame: CGRect(x: 2, y: 5, width: 60, height: 30))
        leftBtn.setTitle(buttonName, for:  UIControlState())
        return leftBtn
    }
    
    static func addRightButton(_ imageBefore:String, imageAfter:String) -> UIButton {
        let rightBtn: UIButton = UIButton(frame: CGRect(x: Int(SCREEN_WIDTH - 48), y: 7, width: 30, height: 30))
        rightBtn.setImage(UIImage(named: imageBefore), for: UIControlState())
        rightBtn.setImage(UIImage(named: imageAfter), for: UIControlState.highlighted)
        return rightBtn
    }
    
    static func addRightButton(_ buttonName:String) -> UIButton {
        let rightBtn: UIButton = UIButton(frame: CGRect(x: Int(SCREEN_WIDTH - 62), y: 7, width: 60, height: 30))
        rightBtn.setTitle(buttonName, for: UIControlState())
        return rightBtn
    }
    
    static func backToRoot(_ navgationViewController: UINavigationController) {
        navgationViewController.popToRootViewController(animated: true)
    }
    
    static func navigatiobBarButtomButton(_ ButtonArray:[UIButton], titleArray:[String], targetArrary:[Selector], viewController:UIViewController, yPosition: CGFloat) {
        
//        navigationController!.navigationBar.frame = CGRectMake(0, 20, CGFloat(SCREEN_WIDTH), 83)
        
        let buttonView = UIView(frame: CGRect(x: 0, y: yPosition, width: CGFloat(SCREEN_WIDTH), height: 40))
        buttonView.backgroundColor = UIColor.black
       
        
        // 画按钮
        for i in 0 ..< 3 {
            ButtonArray[i].frame = CGRect(x: Double((SCREEN_WIDTH/3) * CGFloat(i)), y: 0, width: Double(SCREEN_WIDTH/3), height: 40)
            ButtonArray[i].setTitle(titleArray[i], for: UIControlState())
            ButtonArray[i].setTitleColor(TEXT_COLOR_GREY, for: UIControlState())
            ButtonArray[i].setTitleColor(TEXT_COLOR_LIGHT_GREY, for: UIControlState.highlighted)
            ButtonArray[i].titleLabel?.font = UIFont.systemFont(ofSize: 14)
            ButtonArray[i].backgroundColor = UIColor.white
            ButtonArray[i].addTarget(viewController, action: targetArrary[i], for: UIControlEvents.touchUpInside)
            buttonView.addSubview(ButtonArray[i])
        }
        
        // 画分割线
        for i in 0 ..< 2 {
            let verticalShortLine: UIImageView = UIImageView(frame: CGRect(x: Double((SCREEN_WIDTH/3) * CGFloat(i + 1)), y: 0, width: 0.5, height: 32))
            verticalShortLine.image = UIImage(named: "verticalLineImage")
            verticalShortLine.tag = 100+i
            buttonView.addSubview(verticalShortLine)
        }
        
         viewController.view.addSubview(buttonView)
    }
    
    static func recoverNavigationBar(_ viewsArrary:[UIView], navigationController:UINavigationController) {
        
        if viewsArrary.count > 0 {
            for view in viewsArrary {
                view.removeFromSuperview()
            }
        }
        
        if navigationController.isKind(of: UINavigationController.self) {
            navigationController.navigationBar.frame = CGRect(x: 0, y: 20, width: CGFloat(SCREEN_WIDTH), height: 44)
            navigationController.navigationBar.viewWithTag(100)?.removeFromSuperview()
            navigationController.navigationBar.viewWithTag(101)?.removeFromSuperview()
        }
    }
    
    static func getHorizontalSeporatorImageView (_ y: CGFloat) -> UIImageView  {
        let seporator = UIImageView(image: UIImage(named: "seperateLineImage"))
        seporator.frame = CGRect(x: 20, y: y, width: SCREEN_WIDTH - 40, height: 1)
        return seporator
    }
    
    static func getVerticalSeporatorImageView (_ x:CGFloat, y: CGFloat) -> UIImageView  {
        let seporator = UIImageView(image: UIImage(named: "verticalLineImage"))
        seporator.frame = CGRect(x: x, y: y, width: 1, height: 40)
        return seporator
    }
    
    static func displayAlert(_ title:String, message:String, actions:[UIAlertAction]) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        return alert
    }
}
