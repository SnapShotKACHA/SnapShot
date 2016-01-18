//
//  RegisterViewController.swift
//  SnapShot
//
//  Created by RANRAN on 04/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class RegisterViewController: BasicViewController, UITextFieldDelegate, SnapShotEngineProtocol {
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    
    @IBOutlet weak var SMSTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordValidTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var licenseCheckBox: UIButton!
    @IBOutlet weak var licenseDisplayButton: UIButton!
    @IBOutlet weak var sendSMSButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var userIDWarningLabel: UILabel!
    @IBOutlet weak var phoneNumWarningLabel: UILabel!
    @IBOutlet weak var authCodeWarningLabel: UILabel!
    @IBOutlet weak var passwordWarningLabel: UILabel!
    @IBOutlet weak var passwordValidWarningLabel: UILabel!
    
    
    private var timer:NSTimer?
    private var startCount = 60
    private var loginPushButton:UIButton?
    let USERNAME_TAG = 0101
    let PHONE_NUM_TAG = 0102
    let AUTHCODE_TAG = 0103
    let PASSWORD_TAG = 0104
    let PASSWORD_VALIDE_TAG = 0105
    
    
    override func viewWillAppear(animated: Bool) {
        self.userIDWarningLabel.hidden = true
        self.phoneNumWarningLabel.hidden = true
        self.authCodeWarningLabel.hidden = true
        self.passwordWarningLabel.hidden = true
        self.passwordValidWarningLabel.hidden = true
        self.passwordValidWarningLabel.text = "两次输入不一致"
    }
    
    override func viewDidLoad() {
        self.title = "咔嚓"
        self.userIDTextField.placeholder = "请输入昵称"
        self.userIDTextField.tag = USERNAME_TAG
        self.userIDTextField.delegate = self
        self.phoneNumTextField.placeholder = "请输入电话号码"
        self.phoneNumTextField.tag = PHONE_NUM_TAG
        self.phoneNumTextField.delegate = self
        self.SMSTextField.placeholder = "请输入短信验证码"
        self.SMSTextField.tag = AUTHCODE_TAG
        self.SMSTextField.delegate = self
        self.passwordTextField.secureTextEntry = true
        self.passwordTextField.placeholder = "请输入密码"
        self.passwordTextField.tag = PASSWORD_TAG
        self.passwordTextField.delegate = self
        self.passwordValidTextField.secureTextEntry = true
        self.passwordValidTextField.placeholder = "请再次输入密码"
        self.passwordValidTextField.tag = PASSWORD_VALIDE_TAG
        self.passwordTextField.delegate = self
        self.timeLabel.text = "获取验证码"
        self.loginPushButton = ViewWidgest.addRightButton("登录")
        self.loginPushButton?.addTarget(self, action: "pushToLoginViewController", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationController?.navigationBar.addSubview(self.loginPushButton!)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.loginPushButton?.removeFromSuperview()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.userIDTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.passwordValidTextField.resignFirstResponder()
        self.SMSTextField.resignFirstResponder()
    }
    
    @IBAction func licenseCheckBoxAction(sender: AnyObject) {
    
    }
    @IBAction func licenseDisplayButtonAction(sender: AnyObject) {
    
    }
    
    @IBAction func sendSMSButtonAction(sender: AnyObject) {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("countDown"), userInfo: nil, repeats: true)
        self.sendSMSButton.enabled = false
        if SMSTextField.text != nil {
            SnapShotTaskEngine.getInstance().doGetVerifyCode(phoneNumTextField.text!, engineProtocol: self)
        } else {
            self.authCodeWarningLabel.hidden = false
        }
        
    }

    func countDown() {
        self.startCount--
        self.timeLabel.text = "请\(self.startCount)秒后重试"
        
        if self.startCount < 0 {
            if self.timer == nil {
                return
            }
            self.timeLabel.layer.removeAllAnimations()
            self.timeLabel.text = "请重新获取验证码"
            self.timer?.invalidate()
            self.timer = nil
            self.startCount = 60
        }
    }
    
    func pushToLoginViewController() {
        let loginViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("loginViewController")
        self.navigationController?.popToViewController(loginViewController, animated: true)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        switch textField.tag {
        case USERNAME_TAG:
            if userIDTextField.text == nil {
                self.userIDWarningLabel.hidden = false
            } else if self.userIDTextField.text?.characters.count < 4 || self.userIDTextField.text?.characters.count > 30 {
                self.userIDTextField.text = nil
                self.userIDWarningLabel.hidden = false
            } else {
                self.userIDWarningLabel.hidden = true
            }
            break
            
        case PHONE_NUM_TAG:
            if phoneNumTextField.text == nil {
                self.phoneNumWarningLabel.hidden = false
            } else if !ToolKit.isTelNumber(self.phoneNumTextField.text!){
                self.phoneNumTextField.text = nil
                self.phoneNumWarningLabel.hidden = false
            } else {
                self.phoneNumWarningLabel.hidden = true
            }
            break
            
        case AUTHCODE_TAG:
            if SMSTextField.text == nil {
                self.authCodeWarningLabel.hidden = false
            } else {
                self.authCodeWarningLabel.hidden = true
            }
            break

        case PASSWORD_TAG:
            if passwordTextField.text == nil {
                self.passwordWarningLabel.hidden = false
            } else if self.passwordTextField.text?.characters.count < 6 || self.passwordTextField.text?.characters.count > 16 {
                self.passwordTextField.text = nil
                self.passwordWarningLabel.hidden = false
            } else {
                self.passwordWarningLabel.hidden = true
            }
            break
            
        case PASSWORD_VALIDE_TAG:
            if passwordValidTextField == nil {
                self.passwordValidTextField.hidden = false
            } else if self.passwordValidTextField != passwordTextField.text {
                self.passwordValidTextField.text = nil
                self.passwordValidWarningLabel.hidden = false
            } else {
                self.passwordValidWarningLabel.hidden  = true
            }
            break
            
        default:
            break
        }
    }

    @IBAction func registerButtonAction(sender: AnyObject) {
        if phoneNumTextField.text != nil
            && userIDTextField.text != nil
            && self.SMSTextField.text != nil
            && passwordTextField != nil
            && passwordValidTextField.text != nil
            && passwordTextField.text == passwordValidTextField.text {
            SnapShotTaskEngine.getInstance().doRegister(userIDTextField.text!,
                phoneNum: phoneNumTextField.text!,
                password: passwordTextField.text!,
                verifyCode: SMSTextField.text!, engineProtocol: self)
        } else {
            self.passwordValidWarningLabel.hidden = false
            self.passwordValidWarningLabel.text = "注册失败"
        }
    }
    
    func onTaskError(taskType: Int!, errorCode: Int, extraData: AnyObject) {
        // receive register failed errorCode, handle it!
        // with different errorCode
        if (TASK_TYPE_REGISTER == taskType) {
            print("register task error, handle please!")
        } else if (TASK_TYPE_GET_VERIFY_CODE == taskType) {
            // TODO handle getVerifyCode failed
            print("get verify code task success, handle please!")
        }
    }
    
    func onTaskSuccess(taskType: Int!, successCode: Int, extraData: AnyObject) {
        if (TASK_TYPE_REGISTER == taskType && TASK_RESULT_CODE_SUCCESS == successCode) {
            print("register task success, handle please!")
            SnapShotTaskEngine.getInstance().doLogin(nil, phoneNum: self.phoneNumTextField.text, password: self.passwordTextField.text, engineProtocol: self)
        } else if (TASK_TYPE_GET_VERIFY_CODE == taskType && TASK_RESULT_CODE_SUCCESS == successCode) {
            // TODO handle getVerifyCode succedd
            print("get verify code task success, handle please!")
        } else if (TASK_TYPE_LOGIN == taskType && TASK_RESULT_CODE_SUCCESS == successCode) {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
}