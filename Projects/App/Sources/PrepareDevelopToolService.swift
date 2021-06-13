//
//  PrepareDevelopToolService.swift
//  App
//
//  Created by minsone on 2021/06/13.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
#if canImport(DevelopTool)
import DevelopTool
#endif
#if canImport(FLEX)
import FLEX
#endif

struct PrepareDevelopToolService {
    static func load() {
        #if canImport(DevelopTool)
        HTTPStubs.setup()
        #endif
        #if canImport(FLEX)
        FLEXManager.shared.showExplorer()
        #endif
    }
}
