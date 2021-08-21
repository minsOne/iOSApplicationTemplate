//
//  SettingsBuilder.swift
//  FeatureSettingsDomain
//
//  Created by minsone on 2021/08/18.
//  Copyright © 2021 minsone. All rights reserved.
//

import RIBs

public protocol SettingsDependency: Dependency {}

final class SettingsComponent: Component<SettingsDependency> {}

// MARK: - Builder

public protocol SettingsBuildable: Buildable {
    func build(withListener listener: SettingsListener) -> SettingsRouting
}

public final class SettingsBuilder: Builder<SettingsDependency>, SettingsBuildable {

    public func build(withListener listener: SettingsListener) -> SettingsRouting {
        typealias Component = SettingsComponent
        typealias Presentation = SettingsPresentation
        typealias Interactor = SettingsInteractor
        typealias Router = SettingsRouter
        
        let component = Component(dependency: dependency)
        let viewController = Presentation()
        let interactor = Interactor(presenter: viewController,
                                    useCase: SettingsUseCaseImpl())
        interactor.listener = listener
        
        return Router(interactor: interactor,
                      viewController: viewController)
    }
}
