//
//  SafeArea.swift
//  DesignSystemDemoApp
//
//  Created by minsone on 2021/07/21.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import UIKit

public var hasSafeArea: Bool {
    let window: UIWindow?
    if #available(iOS 13.0, *) {
        window = UIApplication.shared.windows.first
    } else {
        window = UIApplication.shared.keyWindow
    }
    print(window?.safeAreaInsets.bottom)
    return Int(window?.safeAreaInsets.bottom ?? 0) != 0
}
