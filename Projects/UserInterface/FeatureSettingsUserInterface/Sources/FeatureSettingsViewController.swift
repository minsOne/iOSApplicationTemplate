//
//  FeatureSettingsViewController.swift
//  FeatureSettingsUserInterface
//
//  Created by minsone on 2021/08/18.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import RIBs
import RxSwift
import UIKit

public enum FeatureSettingsAction {
    case viewDidLoad
}

public struct FeatureSettingsState {
    public init() {}
}

public protocol FeatureSettingsPresentableListener: AnyObject {
    var action: PublishSubject<FeatureSettingsAction> { get }
    var state: Observable<FeatureSettingsState> { get }
}

public final class FeatureSetttingsViewController: UIViewController {
    public weak var listener: FeatureSettingsPresentableListener?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        listener?.action.onNext(.viewDidLoad)
    }
    
}
