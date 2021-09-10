//
//  SettingsUserInterfaceMapper.swift
//  FeatureSettingsDomain
//
//  Created by damon on 2021/09/09.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import ReactorKit
import FeatureSettingsUserInterface

extension FeatureSettingsUserInterface.SettingsAction {
    var toMapper: SettingsAction {
        switch self {
        case .viewDidLoad: return .viewDidLoad
        case .applyCheckCard: return .applyCheckCard
        case .finish: return .finish
        case .moveToMain: return .moveToMain
        }
    }
}

extension SettingsState {
    var toMapper: FeatureSettingsUserInterface.SettingsState {
        return .init(text: text,
                     계좌종류: 계좌종류)
    }
}

public protocol SettingsPresentableListener: AnyObject {
    var action: ActionSubject<SettingsAction> { get }
    var state: Observable<SettingsState> { get }
}
