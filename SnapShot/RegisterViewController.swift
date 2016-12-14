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
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class RegisterViewController: BasicViewController, UITextFieldDelegate {
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
    
    
    fileprivate var timer:Timer?
    fileprivate var startCount = 60
    fileprivate var loginPushButton:UIButton?
    let USERNAME_TAG = 0101
    let PHONE_NUM_TAG = 0102
    let AUTHCODE_TAG = 0103
    let PASSWORD_TAG = 0104
    let PASSWORD_VALIDE_TAG = 0105
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.userIDWarningLabel.isHidden = true
        self.phoneNumWarningLabel.isHidden = true
        self.authCodeWarningLabel.isHidden = true
        self.passwordWarningLabel.isHidden = true
        self.passwordValidWarningLabel.isHidden = true
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
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.placeholder = "请输入密码"
        self.passwordTextField.tag = PASSWORD_TAG
        self.passwordTextField.delegate = self
        self.passwordValidTextField.isSecureTextEntry = true
        self.passwordValidTextField.placeholder = "请再次输入密码"
        self.passwordValidTextField.tag = PASSWORD_VALIDE_TAG
        self.passwordTextField.delegate = self
        self.timeLabel.text = "获取验证码"
        self.loginPushButton = ViewWidgest.addRightButton("登录")
        self.loginPushButton?.addTarget(self, action: #selector(RegisterViewController.pushToLoginViewController), for: UIControlEvents.touchUpInside)
        self.navigationController?.navigationBar.addSubview(self.loginPushButton!)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.loginPushButton?.removeFromSuperview()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.userIDTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.passwordValidTextField.resignFirstResponder()
        self.SMSTextField.resignFirstResponder()
    }
    
    @IBAction func licenseCheckBoxAction(_ sender: AnyObject) {
    
    }
    @IBAction func licenseDisplayButtonAction(_ sender: AnyObject) {
    
    }
    
    @IBAction func sendSMSButtonAction(_ sender: AnyObject) {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RegisterViewController.countDown), userInfo: nil, repeats: true)
        self.sendSMSButton.isEnabled = false
        if SMSTextField.text != nil {
            SnapShotTaskEngine.getInstance().doGetVerifyCode(phoneNumTextField.text!, engineProtocol: self)
        } else {
            self.authCodeWarningLabel.isHidden = false
        }
        
    }

    func countDown() {
        self.startCount -= 1
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
        let loginViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginViewController")
        self.navigationController?.popToViewController(loginViewController, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case USERNAME_TAG:
            if userIDTextField.text == nil {
                self.userIDWarningLabel.isHidden = false
            } else {
                self.userIDWarningLabel.isHidden = true
            }
            break
            
        case PHONE_NUM_TAG:
            if phoneNumTextField.text == nil {
                self.phoneNumWarningLabel.isHidden = false
            } else if !ToolKit.isTelNumber(self.phoneNumTextField.text!){
                self.phoneNumTextField.text = nil
                self.phoneNumWarningLabel.isHidden = false
            } else {
                self.phoneNumWarningLabel.isHidden = true
            }
            break
            
        case AUTHCODE_TAG:
            if SMSTextField.text == nil {
                self.authCodeWarningLabel.isHidden = false
            } else {
                self.authCodeWarningLabel.isHidden = true
            }
            break

        case PASSWORD_TAG:
            if passwordTextField.text == nil {
                self.passwordWarningLabel.isHidden = false
            } else if self.passwordTextField.text?.characters.count < 6 || self.passwordTextField.text?.characters.count > 16 {
                self.passwordTextField.text = nil
                self.passwordWarningLabel.isHidden = false
            } else {
                self.passwordWarningLabel.isHidden = true
            }
            break
            
        case PASSWORD_VALIDE_TAG:
            if passwordValidTextField == nil {
                self.passwordValidTextField.isHidden = false
            } else if self.passwordValidTextField != passwordTextField.text {
                self.passwordValidTextField.text = nil
                self.passwordValidWarningLabel.isHidden = false
            } else {
                self.passwordValidWarningLabel.isHidden  = true
            }
            break
            
        default:
            break
        }
    }

    @IBAction func registerButtonAction(_ sender: AnyObject) {
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
            self.passwordValidWarningLabel.isHidden = false
            self.passwordValidWarningLabel.text = "注册失败"
        }
    }
    
    override func onTaskError(_ taskType: Int!, errorCode: Int, extraData: AnyObject) {
        // receive register failed errorCode, handle it!
        // with different errorCode
        if (TASK_TYPE_REGISTER == taskType) {
            print("register task error, handle please!")
        } else if (TASK_TYPE_GET_VERIFY_CODE == taskType) {
            // TODO handle getVerifyCode failed
            print("get verify code task success, handle please!")
            let cancelAction = UIAlertAction(title: "注册失败", style: .cancel, handler: nil)
            present(ViewWidgest.displayAlert("注册失败", message: "请重新获取验证码或者更换注册手机号", actions: [cancelAction]), animated: true, completion: nil)
        }
    }
    
    override func onTaskSuccess(_ taskType: Int!, successCode: Int, extraData: AnyObject) {
        if (TASK_TYPE_REGISTER == taskType && TASK_RESULT_CODE_SUCCESS == successCode) {
            print("register task success, handle please!")
            SnapShotTaskEngine.getInstance().doLogin(nil, phoneNum: self.phoneNumTextField.text, password: self.passwordTextField.text, engineProtocol: self)
        } else if (TASK_TYPE_GET_VERIFY_CODE == taskType && TASK_RESULT_CODE_SUCCESS == successCode) {
            // TODO handle getVerifyCode succedd
            print("get verify code task success, handle please!")
        } else if (TASK_TYPE_LOGIN == taskType && TASK_RESULT_CODE_SUCCESS == successCode) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
