//
//  LoginViewContoller.swift
//  SnapShot
//
//  Created by RANRAN on 04/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: BasicViewController, UITextFieldDelegate, SnapShotEngineProtocol {
    
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
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.addSubview(self.registerPushButton)
    }
    
    override func viewDidLoad() {
        self.phoneWarningLabel.hidden = true
        self.passwordWarningLabel.hidden = true
        self.phoneNumTextField.placeholder = "请输入电话号码"
        self.phoneNumTextField.tag = PHONE_NUM_TAG
        self.phoneNumTextField.delegate = self
        self.passwordTextField.secureTextEntry = true
        self.passwordTextField.tag = PASSWORD_TAG
        self.passwordTextField.placeholder = "请输入密码"
        self.passwordTextField.delegate = self
        self.checkBox.setImage(UIImage(named: "checkBoxImage"), forState: UIControlState.Normal)
        self.checkBox.setImage(UIImage(named: "checkBoxSelectedImage"), forState: UIControlState.Selected)
        self.title = "咔嚓"
        self.registerPushButton = ViewWidgest.addRightButton("注册")
        self.registerPushButton.addTarget(self, action: "registerPushButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.registerPushButton.removeFromSuperview()
    }
    
    @IBAction func loginButtonAction(sender: AnyObject) {
        if phoneNumTextField.text != nil && ToolKit.isTelNumber(phoneNumTextField.text!) && passwordTextField.text != nil {
            SnapShotTaskEngine.getInstance().doLogin("", phoneNum: self.phoneNumTextField.text!, password: self.passwordTextField.text!, engineProtocol: self)
        }
    }
    
    func registerPushButtonAction() {
        self.title = ""
        let registerViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("registerViewController") as? RegisterViewController
        self.navigationController?.pushViewController(registerViewController!, animated: true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.phoneNumTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        switch textField.tag {
        case PHONE_NUM_TAG:
            if phoneNumTextField.text == nil {
                self.phoneWarningLabel.hidden = false
            } else if !ToolKit.isTelNumber(self.phoneNumTextField.text!){
                self.phoneNumTextField.text = nil
                self.phoneWarningLabel.hidden = false
            } else {
                self.phoneWarningLabel.hidden = true
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
            
        default:
            break
        }
    }
    
    func onTaskSuccess(taskType: Int!, successCode: Int, extraData: AnyObject) {
        if (taskType == TASK_TYPE_LOGIN && successCode == TASK_RESULT_CODE_SUCCESS) {
            navigationController!.popToRootViewControllerAnimated(true)
        }
    }
    
    func onTaskError(taskType: Int!, errorCode: Int, extraData: AnyObject) {
        if (taskType == TASK_TYPE_LOGIN) {
            let cancelAction = UIAlertAction(title: "重新登录", style: .Cancel, handler: nil)
            presentViewController(ViewWidgest.displayAlert("登录错误", message: "请核对用户名和密码", actions: [cancelAction]), animated: true, completion: nil)
        }
    }
}