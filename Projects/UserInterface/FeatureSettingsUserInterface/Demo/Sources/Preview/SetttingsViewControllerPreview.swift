//
//  SetttingsViewControllerPreview.swift
//  FeatureSettingsUserInterface
//
//  Created by minsone on 2021/08/22.
//  Copyright © 2021 minsone. All rights reserved.
//

#if canImport(SwiftUI) && DEBUG
import UIKit
import SwiftUI
import DesignSystem
import FeatureSettingsUserInterface

struct SetttingsViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            SetttingsViewController()
        }
    }
}
#endif
