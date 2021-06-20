//
//  NavigationControllable.swift
//  ThirdPartyLibraryManager
//
//  Created by minsone on 2021/06/20.
//  Copyright © 2021 minsone. All rights reserved.
//

import UIKit

public protocol NavigationControllable: AnyObject {
    var uinavigationController: UINavigationController { get }
}

public extension NavigationControllable where Self: UINavigationController {
    var uinavigationController: UINavigationController {
        return self
    }
}
