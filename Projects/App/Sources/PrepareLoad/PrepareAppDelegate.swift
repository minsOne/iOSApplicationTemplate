//
//  PrepareAppDelegateService.swift
//  App
//
//  Created by minsone on 2021/06/20.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import AnalyticsKit

struct PrepareAppDelegateService {
    func load() {
        let firebase = AnalyticsKit.Logger.Firebase()
        firebase.register(bundle: .main,
                             plistName: "GoogleService-Info")
        firebase.logEvent(event: .appStart)
    }
}
