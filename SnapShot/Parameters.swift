//
//  Parameters.swift
//  SaveMe
//
//  Created by Jacob Li on 31/07/2015.
//  Copyright (c) 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class Parameters {
    var parametersDic : Dictionary <String, String>?

    init (parameterDictionary: Dictionary<String, String>, signiture: String) {
        self.parametersDic = parameterDictionary
        self.parametersDic!["sig"] = signiture
//        print(self.parametersDic)
    }
    
//    static func generateLoginParam() -> Dictionary <String, String> {
//        var dicitionary: Dictionary <String, String>
//        dicitionary.generate()
//        return dicitionary
//    }
}


