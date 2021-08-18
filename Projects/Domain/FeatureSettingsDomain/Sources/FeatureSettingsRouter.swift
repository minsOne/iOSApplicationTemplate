//
//  FeatureSettingsRouter.swift
//  FeatureSettingsDomain
//
//  Created by minsone on 2021/08/18.
//  Copyright © 2021 minsone. All rights reserved.
//

import RIBs

public protocol FeatureSettingsInteractable: Interactable {
    var router: FeatureSettingsRouting? { get set }
    var listener: FeatureSettingsListener? { get set }
}

public protocol FeatureSettingsViewControllable: ViewControllable {}

final class FeatureSettingsRouter:
    ViewableRouter<FeatureSettingsInteractable, FeatureSettingsViewControllable>,
    FeatureSettingsRouting {
    override init(interactor: FeatureSettingsInteractable,
                  viewController: FeatureSettingsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
