//
//  FeatureSettingsPresentation.swift
//  FeatureSettingsDomain
//
//  Created by minsone on 2021/08/18.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import UIKit
import RIBs
import FeatureSettingsUserInterface

public final class FeatureSettingsPresentation: FeatureSettingsPresentable, FeatureSettingsViewControllable {
    public var listener: FeatureSettingsPresentableListener? {
        get {
            viewController.listener
        }
        set {
            viewController.listener = newValue
        }
    }
    
    public var uiviewController: UIViewController {
        viewController
    }
    
    private let viewController = FeatureSetttingsViewController()
}
