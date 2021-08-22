//
//  SetttingsViewControllerPreview.swift
//  FeatureSettingsUserInterface
//
//  Created by minsone on 2021/08/22.
//  Copyright © 2021 minsone. All rights reserved.
//

import UIKit
import FeatureSettingsUserInterface

#if canImport(SwiftUI) && DEBUG
import SwiftUI
import DesignSystem

struct SetttingsViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            SetttingsViewController()
        }
    }
}
#endif
