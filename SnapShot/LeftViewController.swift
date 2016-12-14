//
//  leftViewController.swift
//  SnapShot
//
//  Created by Jacob Li on 10/10/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class LeftViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userIDLabel: UILabel!
    
    @IBOutlet weak var signatureLabel: UILabel!
    
    
    @IBOutlet weak var homePageButton: UIButton!
    @IBOutlet weak var changeStatuesButton: UIButton!
    @IBOutlet weak var serviceCataButton: UIButton!
    @IBOutlet weak var userProfileButton: UIButton!
    @IBOutlet weak var groupAppointmentButton: UIButton!
    @IBOutlet weak var couponButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var fastAppointButton: UIButton!
    @IBOutlet weak var specialServiceButton: UIButton!
   
    
    
    var loginButton: UIButton?
    var statues: String = "user"
    
    override func viewWillAppear(animated: Bool) {
        self.initLeftViewController()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.loginButton?.removeFromSuperview()
    }
//    override func viewDidAppear(animated: Bool) {
//        self.initLeftViewController()
//    }
    
    override func viewDidLoad() {
        self.profileImage.image = UIImage(named: "profileImageDefault")
//        self.initLeftViewController()
        self.view.backgroundColor = UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 1)
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func initLeftViewController(){
        self.homePageButton.addTarget(AppDelegate(), action: "rightViewShowAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.loginButton = UIButton(frame: CGRectMake(75, 90, 60, 30))
        self.loginButton?.layer.masksToBounds = true
        self.loginButton?.layer.cornerRadius = 5.0
        self.loginButton?.layer.borderWidth = 1.0
        self.loginButton?.layer.borderColor =  TEXT_COLOR_LIGHT_GREY.CGColor
        self.loginButton?.setTitle("登录", forState:  UIControlState.Normal)
        self.loginButton?.setTitleColor(TEXT_COLOR_LIGHT_GREY, forState: UIControlState.Normal)
        self.loginButton?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Selected)
        self.loginButton?.addTarget(self, action: "loginViewDisplay", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.loginButton!)
        self.userProfileButton.enabled = false
        if isLogin == false {
            self.profileImage.hidden = true
            self.userIDLabel.hidden = true
            
            
            
        } else {
            self.loginButton!.removeFromSuperview()
            self.userProfileButton.enabled = true
            self.loginButton?.hidden = true
            self.loginButton?.frame = CGRectMake(-100, -100, 0, 0)
            self.profileImage.hidden = false
            self.userIDLabel.hidden = false
            self.userIDLabel.text = ToolKit.setUserID()
            self.userIDLabel.textColor = TEXT_COLOR_LIGHT_GREY
            self.userIDLabel.adjustsFontSizeToFitWidth = true
            self.view.addSubview(self.userIDLabel)
            self.changeStatuesButton.hidden = false
        }

    }
    
    func loginViewDisplay() {
        print("login button is pressed!")
        self.title = ""
        let loginViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("loginViewController") as? LoginViewController
        self.navigationController?.pushViewController(loginViewController!, animated: true)
    }
    
   
    @IBAction func changeStatusButton(sender: AnyObject) {
        print("changStatusButton button is pressed!")
    }
    
    @IBAction func serviceCataButton(sender: AnyObject) {
        print("changStatusButton button is pressed!")
        let cataViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("cataViewController") as! CataViewController
        self.navigationController?.pushViewController(cataViewController, animated: true)
    }
    
    @IBAction func userProfileButton(sender: AnyObject) {
        print("serviceCataButton button is pressed!")
        let photographerViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("photographerViewController") as! PhotographerViewController
        self.navigationController?.pushViewController(photographerViewController, animated: true)
    }
    
    
    @IBAction func groupAppointmentButton(sender: AnyObject) {
        print("groupAppointmentButton button is pressed!")
        let groupViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("groupViewController") as! GroupViewController
        self.navigationController?.pushViewController(groupViewController, animated: true)
        
    }
    
    @IBAction func fastAppointButton(sender: AnyObject) {
        if statues == "user" {
            let locationViewController = LocationViewController()
            self.navigationController?.pushViewController(locationViewController, animated: true)
        } else if statues == "photographer" {
            let locationPhotographerViewController = LocationPhotographerViewController()
            self.navigationController?.pushViewController(locationPhotographerViewController, animated: true)
        } else {
            
        }
    }
    
    @IBAction func specialServiceButton(sender: AnyObject) {
        let specialServiceViewController = SpecialServiceViewController()
        self.navigationController?.pushViewController(specialServiceViewController, animated: true)
    }
    
    @IBAction func couponButton(sender: AnyObject) {
        print("couponButton button is pressed!")
        let couponViewController = CouponViewController()
        self.navigationController?.pushViewController(couponViewController, animated: true)
    }

    @IBAction func changeStatuesButton(sender: AnyObject) {
        statues = "photographer"
    }
    
    //====================UITextFieldDelegate=================//
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(textField.text)
        return true
    }
    
}