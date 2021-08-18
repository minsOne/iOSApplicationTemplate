//
//  FeatureSettingsInteractor.swift
//  FeatureSettingsDomain
//
//  Created by minsone on 2021/08/18.
//  Copyright © 2021 minsone. All rights reserved.
//

import RIBs
import RxSwift
import FeatureSettingsUserInterface

public protocol FeatureSettingsRouting: ViewableRouting {}

public protocol FeatureSettingsPresentable: Presentable {
    var listener: FeatureSettingsUserInterface.FeatureSettingsPresentableListener? { get set }
}

public protocol FeatureSettingsListener: AnyObject {}

final class FeatureSettingsInteractor:
    PresentableInteractor<FeatureSettingsPresentable>,
    FeatureSettingsInteractable,
    FeatureSettingsUserInterface.FeatureSettingsPresentableListener {
    var action: PublishSubject<FeatureSettingsAction> = .init()
    
    var state: Observable<FeatureSettingsState> = .just(.init())

    weak var router: FeatureSettingsRouting?
    weak var listener: FeatureSettingsListener?
    
    private let useCase: FeatureSettingsUseCase

    init(presenter: FeatureSettingsPresentable,
         useCase: FeatureSettingsUseCase) {
        self.useCase = useCase

        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        useCase.requestSettings()
            .subscribe(onSuccess: { model in print(model) })
            .disposeOnDeactivate(interactor: self)
        
    }

    override func willResignActive() {
        super.willResignActive()
    }
}
