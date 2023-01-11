//
//  Array + Extension.swift
//  WATERCO
//
//  Created by afrazali on 02/12/2019.
//  Copyright © 2019 Afraz Ali. All rights reserved.
//

import Foundation

extension Data {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
