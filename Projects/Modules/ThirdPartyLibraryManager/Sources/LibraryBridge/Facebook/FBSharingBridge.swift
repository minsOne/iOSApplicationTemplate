//
//  FBSharingBridge.swift
//  ThirdPartyLibraryManager
//
//  Created by minsone on 2021/07/13.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import UIKit

public struct FBShareLinkContent {
    public let contentURL: URL
    public init(contentURL: URL) {
        self.contentURL = contentURL
    }
}

public protocol FBSharingDelegate: AnyObject {
    func sharerDidCompleteWithResults(results: [String : Any])
    func sharerDidFailWithError(error: Error)
    func sharerDidCancel()
}

public protocol FBShareDialogInterface {
    init(fromViewController: UIViewController, link: FBShareLinkContent, delegate: FBSharingDelegate)
    func show() -> Bool
}

