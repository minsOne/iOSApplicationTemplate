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
    fileprivate let footerFlexButtonContainer = UIView()
    fileprivate let button = UIButton()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        rootFlexContainer.flex.direction(.column)

        button.setTitle("체크카드 신청하러 가기", for: .normal)
        footerFlexButtonContainer.clipsToBounds = true

        if hasSafeArea {
            footerFlexButtonContainer.flex.margin(0, 16, 0, 16)
                .view?.layer.cornerRadius = 10
        }
        footerFlexButtonContainer.flex.define { flex in
            flex.addItem(button)
                .width(100%)
                .height(100%)
                .backgroundColor(.systemBlue)
        }

        addSubview(rootFlexContainer)
        addSubview(footerFlexButtonContainer)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Layout the flexbox container using PinLayout
        // NOTE: Could be also layouted by setting directly rootFlexContainer.frame
        rootFlexContainer.pin.top(pin.safeArea).horizontally(pin.safeArea).height(120)

        footerFlexButtonContainer.pin.bottom(pin.safeArea).horizontally(pin.safeArea).height(60)

        // Then let the flexbox container layout itself
        rootFlexContainer.flex.layout()
        footerFlexButtonContainer.flex.layout()
    }

    func update(title: String,
                message: String,
                계좌종류: String,
                일일_이체한도: String,
                일회_이체한도: String) {
        let titleLabel = UILabel()
        let msgLabel = UILabel()
        titleLabel.textAlignment = .center
        msgLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        msgLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        msgLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.text = title
        msgLabel.text = message

        let 계좌종류View = FlexLayoutDesignSystem.bothSideLabel(title: "계좌종류", info: 계좌종류)
        let 일일이체한도View = FlexLayoutDesignSystem.bothSideLabel(title: "1일 이체한도", info: 일일_이체한도)
        let 일회이체한도View = FlexLayoutDesignSystem.bothSideLabel(title: "1회 이체한도", info: 일회_이체한도)
        let btn1 = UIButton()
        btn1.setTitle("입출금 알림 설정하기1", for: .normal)

        let btn2 = UIButton()
        btn2.setTitle("입출금 알림 설정하기2", for: .normal)

        rootFlexContainer.flex.define { flex in
            flex.addItem().define { flex in
                flex.addItem(titleLabel)
                flex.addItem()
                    .height(16)
                flex.addItem(msgLabel)
                flex.addItem()
                    .height(30)
            }

            flex.addItem().define { flex in
                flex.addItem(FlexLayoutDesignSystem.line)
                flex.addItem(계좌종류View)
                    .margin(8, 0, 8, 0)
                flex.addItem(FlexLayoutDesignSystem.line)
                flex.addItem(일일이체한도View)
                    .margin(8, 0, 8, 0)
                flex.addItem(FlexLayoutDesignSystem.line)
                flex.addItem(일회이체한도View)
                    .margin(8, 0, 8, 0)
                flex.addItem(FlexLayoutDesignSystem.line)
            }

            flex.addItem().height(24)

            flex.addItem().define { flex in
                flex.direction(.row)
                flex.addItem(btn1)
                    .grow(1)
                    .backgroundColor(.systemGray)
                flex.addItem()
                    .width(16)
                flex.addItem(btn2)
                    .grow(1)
                    .backgroundColor(.systemGreen)
            }
            .height(60)
        }.margin(0, 24, 0, 24)
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

        mainView?.update(title: "입출금통장 개설완료",
                         message: "입출금 통장이 개설되었습니다.\n아래의 내용을 확인해주세요.",
                         계좌종류: "입출금(한도계좌)",
                         일일_이체한도: "1일 최대 200만원",
                         일회_이체한도: "1회 최대 200만원")

        mainView?.rootFlexContainer.flex.layout()
        mainView?.footerFlexButtonContainer.flex.layout()

        mainView?.button.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)

        listener?.action.onNext(.viewDidLoad)
    }

    @objc func tappedButton(_ sender: UIButton) {
        print("Hello world")
    }
}
