//
//  SettingsDataRepository.swift
//  FeatureSettingsDataRepository
//
//  Created by minsone on 2021/08/18.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import FeatureSettingsDomain
import RxSwift
import NetworkAPIs

public struct SettingsRepositoryImpl: FeatureSettingsDomain.SettingsRepository {
    public init() {}

    public func requestSettings() -> Single<SettingsUseCaseModel> {
        let stream: Single<API.Home.BinGet.Response> = Single.create { observer in
            API.Home.BinGet().request { result in
                switch result {
                case .success(let resp): observer(.success(resp))
                case .failure(let error): observer(.failure(error))
                }
            }
            return Disposables.create()
        }
        return stream.map { _ in SettingsUseCaseModel.init(id: 1) }
    }
}
