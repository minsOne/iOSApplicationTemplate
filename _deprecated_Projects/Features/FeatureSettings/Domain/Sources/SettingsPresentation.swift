//
//  SettingsPresentation.swift
//  FeatureSettingsDomain
//
//  Created by minsone on 2021/08/18.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import UIKit
import RIBs
import RxSwift
import RxRelay
import ReactorKit
import FeatureSettingsUserInterface

public final class SettingsPresentation:
    SettingsPresentable,
    SettingsViewControllable {

    public weak var listener: SettingsPresentableListener? {
        didSet {
            listenerMapper = listener.map(SettingsPresentableListenerMapper.init(interactor:))
            viewController.listener = listenerMapper
        }
    }

    public var uiviewController: UIViewController { viewController }
    private let viewController = SettingsViewController()

    private var listenerMapper: SettingsPresentableListenerMapper?

    init() {}
}


private final class SettingsPresentableListenerMapper:
    FeatureSettingsUserInterface.SettingsPresentableListener,
    SettingsPresentableListener {

    var userState: Observable<FeatureSettingsUserInterface.SettingsState>

    var action: ActionSubject<SettingsAction>
    var state: Observable<SettingsState>

    init(interactor: SettingsPresentableListener) {
        self.action = interactor.action
        self.state = interactor.state
        self.userState = interactor.state.map(\.toMapper)
    }

    func action(_ userAction: FeatureSettingsUserInterface.SettingsAction) {
        self.action.onNext(userAction.toMapper)
    }
}
