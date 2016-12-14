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
    
    override func viewWillAppear(_ animated: Bool) {
        self.initLeftViewController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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
        self.homePageButton.addTarget(AppDelegate(), action: "rightViewShowAction", for: UIControlEvents.touchUpInside)
        self.loginButton = UIButton(frame: CGRect(x: 75, y: 90, width: 60, height: 30))
        self.loginButton?.layer.masksToBounds = true
        self.loginButton?.layer.cornerRadius = 5.0
        self.loginButton?.layer.borderWidth = 1.0
        self.loginButton?.layer.borderColor =  TEXT_COLOR_LIGHT_GREY.cgColor
        self.loginButton?.setTitle("登录", for:  UIControlState())
        self.loginButton?.setTitleColor(TEXT_COLOR_LIGHT_GREY, for: UIControlState())
        self.loginButton?.setTitleColor(UIColor.black, for: UIControlState.selected)
        self.loginButton?.addTarget(self, action: #selector(LeftViewController.loginViewDisplay), for: UIControlEvents.touchUpInside)
        self.view.addSubview(self.loginButton!)
        self.userProfileButton.isEnabled = false
        if isLogin == false {
            self.profileImage.isHidden = true
            self.userIDLabel.isHidden = true
            
            
            
        } else {
            self.loginButton!.removeFromSuperview()
            self.userProfileButton.isEnabled = true
            self.loginButton?.isHidden = true
            self.loginButton?.frame = CGRect(x: -100, y: -100, width: 0, height: 0)
            self.profileImage.isHidden = false
            self.userIDLabel.isHidden = false
            self.userIDLabel.text = ToolKit.setUserID()
            self.userIDLabel.textColor = TEXT_COLOR_LIGHT_GREY
            self.userIDLabel.adjustsFontSizeToFitWidth = true
            self.view.addSubview(self.userIDLabel)
            self.changeStatuesButton.isHidden = false
        }

    }
    
    func loginViewDisplay() {
        print("login button is pressed!")
        self.title = ""
        let loginViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginViewController") as? LoginViewController
        self.navigationController?.pushViewController(loginViewController!, animated: true)
    }
    
   
    @IBAction func changeStatusButton(_ sender: AnyObject) {
        print("changStatusButton button is pressed!")
    }
    
    @IBAction func serviceCataButton(_ sender: AnyObject) {
        print("changStatusButton button is pressed!")
        let cataViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "cataViewController") as! CataViewController
        self.navigationController?.pushViewController(cataViewController, animated: true)
    }
    
    @IBAction func userProfileButton(_ sender: AnyObject) {
        print("serviceCataButton button is pressed!")
        let photographerViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "photographerViewController") as! PhotographerViewController
        self.navigationController?.pushViewController(photographerViewController, animated: true)
    }
    
    
    @IBAction func groupAppointmentButton(_ sender: AnyObject) {
        print("groupAppointmentButton button is pressed!")
        let groupViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "groupViewController") as! GroupViewController
        self.navigationController?.pushViewController(groupViewController, animated: true)
        
    }
    
    @IBAction func fastAppointButton(_ sender: AnyObject) {
        if statues == "user" {
            let locationViewController = LocationViewController()
            self.navigationController?.pushViewController(locationViewController, animated: true)
        } else if statues == "photographer" {
            let locationPhotographerViewController = LocationPhotographerViewController()
            self.navigationController?.pushViewController(locationPhotographerViewController, animated: true)
        } else {
            
        }
    }
    
    @IBAction func specialServiceButton(_ sender: AnyObject) {
        let specialServiceViewController = SpecialServiceViewController()
        self.navigationController?.pushViewController(specialServiceViewController, animated: true)
    }
    
    @IBAction func couponButton(_ sender: AnyObject) {
        print("couponButton button is pressed!")
        let couponViewController = CouponViewController()
        self.navigationController?.pushViewController(couponViewController, animated: true)
    }

    @IBAction func changeStatuesButton(_ sender: AnyObject) {
        statues = "photographer"
    }
    
    //====================UITextFieldDelegate=================//
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(textField.text)
        return true
    }
    
}
