//
//  Dictionary.swift
//  LOL
//
//  Created by Oh Sangho on 2018. 10. 19..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import Foundation

extension Dictionary {
    func compactMapValues<U>(
        _ transform: (Value) throws -> U?
        ) rethrows -> [Key: U] {
        var result = [Key: U]()
        for (key, value) in self {
            result[key] = try transform(value)
        }
        return result
    }
}
