//
//  SettingsInteractor.swift
//  FeatureSettingsDomain
//
//  Created by minsone on 2021/08/18.
//  Copyright © 2021 minsone. All rights reserved.
//

import RIBs
import RxSwift
import FeatureSettingsUserInterface

public protocol SettingsRouting: ViewableRouting {}

public protocol SettingsPresentable: Presentable {
    var listener: FeatureSettingsUserInterface.SettingsPresentableListener? { get set }
}

public protocol SettingsListener: AnyObject {}

final class SettingsInteractor:
    PresentableInteractor<SettingsPresentable>,
    SettingsInteractable,
    FeatureSettingsUserInterface.SettingsPresentableListener {
    var action: PublishSubject<SettingsAction> = .init()
    
    var state: Observable<SettingsState> = .just(.init())

    weak var router: SettingsRouting?
    weak var listener: SettingsListener?
    
    private let useCase: SettingsUseCase

    init(presenter: SettingsPresentable,
         useCase: SettingsUseCase) {
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
