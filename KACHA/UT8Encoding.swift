//
//  UT8Encoding.swift
//  SnapShot
//
//  Created by Jacob Li on 20/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation

public class UTF8Encoding {
    public static func encode(bytes: Array<UInt8>) -> String {
        var encodedString = ""
        var decoder = UTF8()
        var generator = bytes.generate()
        var finished: Bool = false
        repeat {
            let decodingResult = decoder.decode(&generator)
            switch decodingResult {
            case .Result(let char):
                encodedString.append(char)
            case .EmptyInput:
                finished = true
                /* ignore errors and unexpected values */
            case .Error:
                finished = true
            }
        } while (!finished)
        return encodedString
    }
    
    public static func decode(str: String) -> Array<UInt8> {
        var decodedBytes = Array<UInt8>()
        for b in str.utf8 {
            decodedBytes.append(b)
        }
        return decodedBytes
    }
}
