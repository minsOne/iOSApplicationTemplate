//
//  RootRouter.swift
//  App
//
//  Created by minsone on 2021/06/20.
//  Copyright © 2021 minsone. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    override init(interactor: RootInteractable,
                  viewController: RootViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
