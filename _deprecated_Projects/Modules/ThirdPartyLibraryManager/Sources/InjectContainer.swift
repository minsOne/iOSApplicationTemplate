//
//  InjectContainer.swift
//  ThirdPartyLibraryManager
//
//  Created by minsone on 2021/08/19.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import Swinject
import InjectPropertyWrapper

extension Container: InjectPropertyWrapper.Resolver {}

public struct InjectContainer {
    public static let container: Container = {
        let _cotainer = Container()
        InjectSettings.resolver = _cotainer
        return _cotainer
    }()
}
