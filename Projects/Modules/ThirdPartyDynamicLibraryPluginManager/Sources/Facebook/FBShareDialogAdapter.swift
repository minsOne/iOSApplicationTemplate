//
//  FBShareDialogBridge.swift
//  ThirdPartyDynamicLibraryPluginManager
//
//  Created by minsone on 2021/07/13.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import UIKit
import ThirdPartyLibraryManager
import FBSDKShareKit

public final class FBShareDialogAdapter:
    NSObject,
    FBShareDialogInterface,
    SharingDelegate {
    
    public var dialog: ShareDialog?
    public weak var delegate: FBSharingDelegate?

    public required init(fromViewController: UIViewController,
                  link: FBShareLinkContent,
                  delegate: FBSharingDelegate) {
        super.init()
        
        let shareContent = ShareLinkContent()
        shareContent.contentURL = link.contentURL
        self.delegate = delegate
        self.dialog = ShareDialog(fromViewController: fromViewController, content: shareContent, delegate: self)
    }
    
    public func show() -> Bool {
        return dialog?.show() ?? false
    }
    
    public func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        delegate?.sharerDidCompleteWithResults(results: results)
    }
    
    public func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        delegate?.sharerDidFailWithError(error: error)
    }
    
    public func sharerDidCancel(_ sharer: Sharing) {
        delegate?.sharerDidCancel()
    }
}
