//
//  Optional+Extension.swift
//  UtilityKit
//
//  Created by minsone on 2021/06/13.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation

public extension Optional {
    func ifNil(then value: Wrapped) -> Wrapped {
        return (self ?? value)
    }
}
