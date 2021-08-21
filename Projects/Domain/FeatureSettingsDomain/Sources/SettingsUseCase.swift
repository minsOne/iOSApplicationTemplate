//
//  SettingsUseCase.swift
//  FeatureSettingsDomain
//
//  Created by minsone on 2021/08/18.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import RxSwift
import Swinject
import InjectPropertyWrapper

public struct SettingsUseCaseModel {
    public let id: Int
    
    public init(id: Int) {
        self.id = id
    }
}

protocol SettingsUseCase {
    func requestSettings() -> Single<SettingsUseCaseModel>
}

public protocol SettingsRepository {
    func requestSettings() -> Single<SettingsUseCaseModel>
}

struct SettingsUseCaseImpl: SettingsUseCase {
    @Inject private var repository: SettingsRepository

    func requestSettings() -> Single<SettingsUseCaseModel> {
        return repository.requestSettings()
    }
}


