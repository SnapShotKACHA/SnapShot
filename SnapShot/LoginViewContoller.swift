//
//  LoginViewContoller.swift
//  SnapShot
//
//  Created by RANRAN on 04/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit
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


class LoginViewController: BasicViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var phoneWarningLabel: UILabel!
    
    @IBOutlet weak var passwordWarningLabel: UILabel!
    
    @IBOutlet weak var checkBox: UIButton!
    
    @IBOutlet weak var forgetPasswordButton: UIButton!
    
    var registerPushButton: UIButton!
    let PHONE_NUM_TAG = 0201
    let PASSWORD_TAG = 0202
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.addSubview(self.registerPushButton)
    }
    
    override func viewDidLoad() {
        self.phoneWarningLabel.isHidden = true
        self.passwordWarningLabel.isHidden = true
        self.phoneNumTextField.placeholder = "请输入电话号码"
        self.phoneNumTextField.tag = PHONE_NUM_TAG
        self.phoneNumTextField.delegate = self
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField.tag = PASSWORD_TAG
        self.passwordTextField.placeholder = "请输入密码"
        self.passwordTextField.delegate = self
        self.checkBox.setImage(UIImage(named: "checkBoxImage"), for: UIControlState())
        self.checkBox.setImage(UIImage(named: "checkBoxSelectedImage"), for: UIControlState.selected)
        self.title = "咔嚓"
        self.registerPushButton = ViewWidgest.addRightButton("注册")
        self.registerPushButton.addTarget(self, action: #selector(LoginViewController.registerPushButtonAction), for: UIControlEvents.touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.registerPushButton.removeFromSuperview()
    }
    
    @IBAction func loginButtonAction(_ sender: AnyObject) {
        if phoneNumTextField.text != nil && ToolKit.isTelNumber(phoneNumTextField.text!) && passwordTextField.text != nil {
            SnapShotTaskEngine.getInstance().doLogin("", phoneNum: self.phoneNumTextField.text!, password: self.passwordTextField.text!, engineProtocol: self)
        }
    }
    
    func registerPushButtonAction() {
        self.title = ""
        let registerViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "registerViewController") as? RegisterViewController
        self.navigationController?.pushViewController(registerViewController!, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.phoneNumTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case PHONE_NUM_TAG:
            if phoneNumTextField.text == nil {
                self.phoneWarningLabel.isHidden = false
            } else if !ToolKit.isTelNumber(self.phoneNumTextField.text!){
                self.phoneNumTextField.text = nil
                self.phoneWarningLabel.isHidden = false
            } else {
                self.phoneWarningLabel.isHidden = true
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
            
        default:
            break
        }
    }
    
    override func onTaskSuccess(_ taskType: Int!, successCode: Int, extraData: AnyObject) {
        if (taskType == TASK_TYPE_LOGIN && successCode == TASK_RESULT_CODE_SUCCESS) {
            navigationController!.popToRootViewController(animated: true)
        }
    }
    
    override func onTaskError(_ taskType: Int!, errorCode: Int, extraData: AnyObject) {
        if (taskType == TASK_TYPE_LOGIN) {
            let cancelAction = UIAlertAction(title: "重新登录", style: .cancel, handler: nil)
            present(ViewWidgest.displayAlert("登录错误", message: "请核对用户名和密码", actions: [cancelAction]), animated: true, completion: nil)
        }
    }
}
