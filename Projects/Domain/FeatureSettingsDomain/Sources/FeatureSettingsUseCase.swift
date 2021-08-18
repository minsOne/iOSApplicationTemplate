//
//  FeatureSettingsUseCase.swift
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

protocol FeatureSettingsUseCase {
    func requestSettings() -> Single<SettingsUseCaseModel>
}

public protocol FeatureSettingsRepository {
    func requestSettings() -> Single<SettingsUseCaseModel>
}

struct FeatureSettingsUseCaseImpl: FeatureSettingsUseCase {
    @Inject private var repository: FeatureSettingsRepository

    func requestSettings() -> Single<SettingsUseCaseModel> {
        return repository.requestSettings()
    }
}


