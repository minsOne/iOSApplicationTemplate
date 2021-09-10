//
//  SettingsRouter.swift
//  FeatureSettingsDomain
//
//  Created by minsone on 2021/08/18.
//  Copyright © 2021 minsone. All rights reserved.
//

import RIBs

public protocol SettingsInteractable: Interactable {
    var router: SettingsRouting? { get set }
    var listener: SettingsListener? { get set }
}

public protocol SettingsViewControllable: ViewControllable {}

final class SettingsRouter:
    ViewableRouter<SettingsInteractable, SettingsViewControllable>,
    SettingsRouting {
    func routeToApplyCard() {
        
    }

    override init(interactor: SettingsInteractable,
                  viewController: SettingsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
