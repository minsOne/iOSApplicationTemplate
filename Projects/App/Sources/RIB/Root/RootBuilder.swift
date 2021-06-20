//
//  RootBuilder.swift
//  App
//
//  Created by minsone on 2021/06/20.
//  Copyright © 2021 minsone. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {}

final class RootComponent: Component<RootDependency> {}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    func build() -> LaunchRouting {
        let _ = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)

        return RootRouter(interactor: interactor,
                          viewController: viewController)
    }
}
