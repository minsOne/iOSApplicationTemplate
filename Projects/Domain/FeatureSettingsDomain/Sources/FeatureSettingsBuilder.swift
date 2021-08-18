//
//  FeatureSettingsBuilder.swift
//  FeatureSettingsDomain
//
//  Created by minsone on 2021/08/18.
//  Copyright © 2021 minsone. All rights reserved.
//

import RIBs

public protocol FeatureSettingsDependency: Dependency {}

final class FeatureSettingsComponent: Component<FeatureSettingsDependency> {}

// MARK: - Builder

public protocol FeatureSettingsBuildable: Buildable {
    func build(withListener listener: FeatureSettingsListener) -> FeatureSettingsRouting
}

public final class FeatureSettingsBuilder: Builder<FeatureSettingsDependency>, FeatureSettingsBuildable {

    public func build(withListener listener: FeatureSettingsListener) -> FeatureSettingsRouting {
        typealias Component = FeatureSettingsComponent
        typealias Presentation = FeatureSettingsPresentation
        typealias Interactor = FeatureSettingsInteractor
        typealias Router = FeatureSettingsRouter
        
        let component = Component(dependency: dependency)
        let viewController = Presentation()
        let interactor = Interactor(presenter: viewController,
                                    useCase: FeatureSettingsUseCaseImpl())
        interactor.listener = listener
        
        return Router(interactor: interactor,
                      viewController: viewController)
    }
}
