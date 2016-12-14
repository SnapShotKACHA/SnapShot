//
//  UT8Encoding.swift
//  SnapShot
//
//  Created by Jacob Li on 20/11/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation

open class UTF8Encoding {
    open static func encode(_ bytes: Array<UInt8>) -> String {
        var encodedString = ""
        var decoder = UTF8()
        var generator = bytes.makeIterator()
        var finished: Bool = false
        repeat {
            let decodingResult = decoder.decode(&generator)
            switch decodingResult {
            case .scalarValue(let char):
                encodedString.append(String(char))
            case .emptyInput:
                finished = true
                /* ignore errors and unexpected values */
            case .error:
                finished = true
            }
        } while (!finished)
        return encodedString
    }
    
    open static func decode(_ str: String) -> Array<UInt8> {
        var decodedBytes = Array<UInt8>()
        for b in str.utf8 {
            decodedBytes.append(b)
        }
        return decodedBytes
    }
}
