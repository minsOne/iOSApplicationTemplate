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
import DesignSystem
import PinLayout
import FlexLayout

public enum SettingsAction {
    case viewDidLoad
}

public struct SettingsState {
    public init() {}
}

public protocol SettingsPresentableListener: AnyObject {
    var action: PublishSubject<SettingsAction> { get }
    var state: Observable<SettingsState> { get }
}

class SettingsView: UIView {
    fileprivate let rootFlexContainer = UIView()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        // Yoga's C Example
        rootFlexContainer.flex.direction(.row).padding(20).define { (flex) in
            flex.addItem().width(80).marginEnd(20).backgroundColor(.systemBlue)
            flex.addItem().height(25).alignSelf(.center).grow(1).backgroundColor(.black)
        }.backgroundColor(.systemGreen)
        addSubview(rootFlexContainer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Layout the flexbox container using PinLayout
        // NOTE: Could be also layouted by setting directly rootFlexContainer.frame
        rootFlexContainer.pin.top(pin.safeArea).horizontally(pin.safeArea).height(120)

        // Then let the flexbox container layout itself
        rootFlexContainer.flex.layout()
    }
}



public final class SetttingsViewController: UIViewController {
    public weak var listener: SettingsPresentableListener?

    fileprivate var mainView: SettingsView? {
        return self.view as? SettingsView
    }


    public override func loadView() {
        view = SettingsView()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .systemRed
        
        listener?.action.onNext(.viewDidLoad)
    }
    
}

/*
 class YogaExampleAViewController: BaseViewController {
 fileprivate var mainView: YogaExampleAView {
 return self.view as! YogaExampleAView
 }

 init(pageType: PageType) {
 super.init()
 title = pageType.text
 }

 required init?(coder aDecoder: NSCoder) {
 super.init(coder: aDecoder)
 }

 override func loadView() {
 view = YogaExampleAView()
 }
 }

 import UIKit
 import FlexLayout
 import PinLayout

 class YogaExampleAView: UIView {
 fileprivate let rootFlexContainer = UIView()

 init() {
 super.init(frame: .zero)
 backgroundColor = .white

 // Yoga's C Example
 rootFlexContainer.flex.direction(.row).padding(20).define { (flex) in
 flex.addItem().width(80).marginEnd(20).backgroundColor(.flexLayoutColor)
 flex.addItem().height(25).alignSelf(.center).grow(1).backgroundColor(.black)
 }
 addSubview(rootFlexContainer)
 }

 required init?(coder aDecoder: NSCoder) {
 super.init(coder: aDecoder)
 }

 override func layoutSubviews() {
 super.layoutSubviews()

 // Layout the flexbox container using PinLayout
 // NOTE: Could be also layouted by setting directly rootFlexContainer.frame
 rootFlexContainer.pin.top(pin.safeArea).horizontally(pin.safeArea).height(120)

 // Then let the flexbox container layout itself
 rootFlexContainer.flex.layout()
 }
 }

 */
