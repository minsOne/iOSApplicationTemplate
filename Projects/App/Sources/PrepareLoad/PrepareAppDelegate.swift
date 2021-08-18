//
//  PrepareAppDelegateService.swift
//  App
//
//  Created by minsone on 2021/06/20.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import AnalyticsKit
import ThirdPartyLibraryManager
import ThirdPartyDynamicLibraryPluginManager
import InjectionManager

struct PrepareAppDelegateService {
    func load() {
        Logger.Firebase.register(bundle: .main, plistName: "GoogleService-Info")
        Logger.Firebase.logEvent(event: .appStart)

        ThirdPartyLibraryManager.FBDIContainer.fbshareDialog = ThirdPartyDynamicLibraryPluginManager.FBShareDialogAdapter.self
        InjectContainerManager().register()
    }
}
