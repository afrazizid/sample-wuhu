//
//  Array + Extension.swift
//  WATERCO
//
//  Created by Abdulqadar on 02/12/2019.
//  Copyright © 2019 Abdul Qadar. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}
