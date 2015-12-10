//
//  UrlAssembler.swift
//  SnapShot
//
//  Created by Jacob Li on 19/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation

class UrlAssembler {
    var url:String
    
    init (taskUrl: String, parameterDictionary: Dictionary<String, String>, signiture: String) {
        self.url = taskUrl + "?"
        let sortedDic = parameterDictionary.sort{$0.0 < $1.0}
        //        sortedDic = sortedDic.reverse()
        for (parameter, parameterValue) in sortedDic {
            url += "\(parameter)=\(parameterValue)&"
        }
        url += "sig=\(signiture)"
    }
}