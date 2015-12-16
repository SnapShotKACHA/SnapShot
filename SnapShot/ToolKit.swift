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
        var timeStamp = String(NSDate().timeIntervalSince1970)
        timeStamp.removeAtIndex(timeStamp.startIndex.advancedBy(10))
        timeStamp = timeStamp.substringToIndex(timeStamp.startIndex.advancedBy(13))
        return timeStamp
    }
    
    static func stringToTimeStamp(stringTime:String)->String {
        
        let dfmatter = NSDateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日"
        let date = dfmatter.dateFromString(stringTime)
        
        let dateStamp:NSTimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        print(dateSt)
        return String(dateSt)
        
    }
    
    static func timeStampToString(timeStamp:String)->String {
        
        let string = NSString(string: timeStamp)
        
        let timeSta:NSTimeInterval = string.doubleValue
        let dfmatter = NSDateFormatter()
        dfmatter.dateFormat="yyyy年MM月dd日"
        
        let date = NSDate(timeIntervalSince1970: timeSta)
        
        print(dfmatter.stringFromDate(date))
        return dfmatter.stringFromDate(date)
    }
    
    static func isTelNumber(num:NSString)->Bool
    {
        let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluateWithObject(num) == true)
            || (regextestcm.evaluateWithObject(num)  == true)
            || (regextestct.evaluateWithObject(num) == true)
            || (regextestcu.evaluateWithObject(num) == true))
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
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.destroy()
        
        return String(format: hash as String)
    }
}

extension NSDate {
//    let numberOfDaysInCurrentMonth: Int?
//    var firstDayOfCurrentMonth: NSDate?
//    var weekly: Int?

    func numberOfDaysInCurrentMonth() -> Int {
        return NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: self).length
    }
    
    func firstDayOfCurrentMonth() -> NSDate {
        let startDate:NSDate?
        NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Month, startDate: startDate , interval: nil, forDate: self)
        return startDate!
    }
}
