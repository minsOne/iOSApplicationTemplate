//
//  NavigationViewableRouting.swift
//  ThirdPartyLibraryManager
//
//  Created by minsone on 2021/06/20.
//  Copyright © 2021 minsone. All rights reserved.
//

import RIBs
import UIKit

public protocol NavigationViewableRouting: ViewableRouting {
    var navigationControllable: NavigationControllable { get }

    func pushViewController(_ viewControllable: ViewControllable, animated: Bool)
    func popToViewController(_ viewControllable: ViewControllable, animated: Bool)
    func dismissViewController(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?)
    func presentViewController(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?)
}

public extension NavigationViewableRouting {
    func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
        let navi = navigationControllable.uinavigationController
        if navi.children.isEmpty {
            navi.setViewControllers([viewControllable.uiviewController], animated: animated)
        } else {
            navi.pushViewController(viewControllable.uiviewController, animated: animated)
        }
    }

    func popToViewController(_ viewControllable: ViewControllable, animated: Bool) {
        let navi = navigationControllable.uinavigationController
        navi.popToViewController(viewControllable.uiviewController, animated: animated)
    }
    
    func dismissViewController(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?) {
        viewControllable.uiviewController.dismiss(animated: animated,
                                                  completion: completion)
    }
    
    func presentViewController(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?) {
        let navi = navigationControllable.uinavigationController
        navi.present(viewControllable.uiviewController,
                     animated: animated,
                     completion: completion)
    }
}
