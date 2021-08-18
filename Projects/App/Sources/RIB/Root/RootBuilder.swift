//
//  RootBuilder.swift
//  App
//
//  Created by minsone on 2021/06/20.
//  Copyright © 2021 minsone. All rights reserved.
//

import RIBs
import FeatureSettingsDomain

protocol RootDependency: Dependency {}

final class RootComponent:
    Component<RootDependency>,
    FeatureSettingsDependency {}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    func build() -> LaunchRouting {
        typealias Component = RootComponent
        typealias ViewController = RootViewController
        typealias Interactor = RootInteractor
        typealias Router = RootRouter

        let component = Component(dependency: dependency)
        let viewController = ViewController()
        let interactor = Interactor(presenter: viewController)

        let settingsBuilder = FeatureSettingsBuilder(dependency: component)

        return Router(interactor: interactor,
                      viewController: viewController,
                      settingsBuilder: settingsBuilder)
    }
}
