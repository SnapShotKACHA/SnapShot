//
//  ToolKit.swift
//  SnapShot
//
//  Created by RANRAN on 21/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class ToolKit {
    static func getTimeStamp() -> String {
        var timeStamp = String(Date().timeIntervalSince1970)
        timeStamp.remove(at: timeStamp.characters.index(timeStamp.startIndex, offsetBy: 10))
        timeStamp = timeStamp.substring(to: timeStamp.characters.index(timeStamp.startIndex, offsetBy: 13))
        return timeStamp
    }
    
    static func setUserID() -> String
    {
        if userDefaults.object(forKey: "username") !== nil {
            return userDefaults.object(forKey: "username") as! String
        } else if userDefaults.object(forKey: "phoneNum") != nil {
            return userDefaults.object(forKey: "phoneNum") as! String
        } else {
            return "未获得用户名"
        }
        
    }
    
    static func iOS8() -> Bool {
        let versionCode:String = UIDevice.current.systemVersion
        let start:String.Index = versionCode.characters.index(versionCode.startIndex, offsetBy: 0)
        let end:String.Index = versionCode.characters.index(versionCode.startIndex, offsetBy: 1)
        let range = (start ..< end)
        let version = NSString(string: UIDevice.current.systemVersion.substring(with: range)).doubleValue
        return version >= 8.0
    }

    
    static func stringToTimeStamp(_ stringTime:String)->String {
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日"
        let date = dfmatter.date(from: stringTime)
        
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        print(dateSt)
        return String(dateSt)
        
    }
    
    static func timeStampToString(_ timeStamp:String)->String {
        
        let string = NSString(string: timeStamp)
        
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="MM月dd日"
        
        let date = Date(timeIntervalSince1970: timeSta)
        
        print(dfmatter.string(from: date))
        return dfmatter.string(from: date)
    }
    
    static func isTelNumber(_ num:NSString)->Bool
    {
        let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: num) == true)
            || (regextestcm.evaluate(with: num)  == true)
            || (regextestct.evaluate(with: num) == true)
            || (regextestcu.evaluate(with: num) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }

}



extension String  {
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deinitialize()
        
        return String(format: hash as String)
    }
}

extension Date {
//    let numberOfDaysInCurrentMonth: Int?
//    var firstDayOfCurrentMonth: NSDate?
//    var weekly: Int?

    func numberOfDaysInCurrentMonth() -> Int {
        return (Calendar.current as NSCalendar).range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self).length
    }
    
//    func firstDayOfCurrentMonth() -> NSDate {
//        let startDate:NSDate?
//        NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Month, startDate: startDate , interval: nil, forDate: self)
//        return startDate!
//    }
}
