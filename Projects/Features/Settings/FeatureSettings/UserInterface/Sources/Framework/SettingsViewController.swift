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
    case applyCheckCard
    case finish
    case moveToMain
}

public struct SettingsState {
    var text: String
    var 계좌종류: String

    public init(text: String,
                계좌종류: String) {
        self.text = text
        self.계좌종류 = 계좌종류
    }
}

public protocol SettingsPresentableListener: AnyObject {
    func action(_ userAction: SettingsAction)
    var userState: Observable<SettingsState> { get }
}

class SettingsView: UIView {
    fileprivate let rootFlexContainer = UIView()
    fileprivate let footerFlexButtonContainer = UIView()
    fileprivate let titleLabel = UILabel()
    fileprivate let msgLabel = UILabel()
    fileprivate var 계좌종류View: BothSideLabelView?
    fileprivate let confirmButton = UIButton()
    fileprivate let menuBtn1 = UIButton()
    fileprivate let menuBtn2 = UIButton()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        rootFlexContainer.flex.direction(.column)

        confirmButton.setTitle("체크카드 신청하러 가기", for: .normal)
        footerFlexButtonContainer.clipsToBounds = true

        if hasSafeArea {
            footerFlexButtonContainer.flex.margin(0, 16, 0, 16)
                .view?.layer.cornerRadius = 10
        }
        footerFlexButtonContainer.flex.define { flex in
            flex.addItem(confirmButton)
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
        rootFlexContainer.pin.top(pin.safeArea).horizontally(pin.safeArea)
        rootFlexContainer.flex.layout(mode: .adjustHeight)

        footerFlexButtonContainer.pin.bottom(pin.safeArea).horizontally(pin.safeArea).height(60)

        // Then let the flexbox container layout itself
        rootFlexContainer.flex.layout()
        footerFlexButtonContainer.flex.layout()
    }

    func update(message: String) {
        msgLabel.text = message
        msgLabel.flex.markDirty()
        rootFlexContainer.flex.layout()
    }

    func update(계좌종류: String) {
        self.계좌종류View?.update(info: 계좌종류)
        self.계좌종류View?.container.flex.markDirty()
        rootFlexContainer.flex.layout()
    }

    func update(title: String,
                message: String,
                계좌종류: String,
                일일_이체한도: String,
                일회_이체한도: String) {
        titleLabel.textAlignment = .center
        msgLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        msgLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        msgLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.text = title
        msgLabel.text = message

        let 계좌종류View = FlexLayoutDesignSystem.bothSideLabel(title: "계좌종류", info: 계좌종류)
        self.계좌종류View = 계좌종류View

        let 일일이체한도View = FlexLayoutDesignSystem.bothSideLabel(title: "1일 이체한도", info: 일일_이체한도)
        let 일회이체한도View = FlexLayoutDesignSystem.bothSideLabel(title: "1회 이체한도", info: 일회_이체한도)
        menuBtn1.setTitle("메인으로 이동", for: .normal)
        menuBtn2.setTitle("닫기", for: .normal)

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
                flex.addItem(계좌종류View.container)
                    .margin(8, 0, 8, 0)
                flex.addItem(FlexLayoutDesignSystem.line)
                flex.addItem(일일이체한도View.container)
                    .margin(8, 0, 8, 0)
                flex.addItem(FlexLayoutDesignSystem.line)
                flex.addItem(일회이체한도View.container)
                    .margin(8, 0, 8, 0)
                flex.addItem(FlexLayoutDesignSystem.line)
            }

            flex.addItem().height(24)

            flex.addItem().define { flex in
                flex.direction(.row)
                flex.addItem(menuBtn1)
                    .grow(1)
                    .backgroundColor(.systemGray)
                flex.addItem()
                    .width(16)
                flex.addItem(menuBtn2)
                    .grow(1)
                    .backgroundColor(.systemGreen)
            }
            .height(60)
        }.margin(0, 24, 0, 24)
    }
}

public final class SettingsViewController: UIViewController {
    public weak var listener: SettingsPresentableListener?

    private let disposeBag = DisposeBag()

    private let mainView = SettingsView()

    public override func loadView() {
        view = mainView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        mainView.update(title: "입출금통장 개설완료",
                         message: "입출금 통장이 개설되었습니다.\n아래의 내용을 확인해주세요.",
                         계좌종류: "-",
                         일일_이체한도: "1일 최대 200만원",
                         일회_이체한도: "1회 최대 200만원")

        mainView.confirmButton.addTarget(self,
                                         action: #selector(tappedButton(_:)),
                                         for: .touchUpInside)
        mainView.menuBtn1.addTarget(self,
                                    action: #selector(tappedMoveToMainButton(_:)),
                                    for: .touchUpInside)
        mainView.menuBtn2.addTarget(self,
                                    action: #selector(tappedFinishButton(_:)),
                                    for: .touchUpInside)

        mainView.rootFlexContainer.flex.layout()
        mainView.footerFlexButtonContainer.flex.layout()

        listener?.userState
            .debug()
            .subscribe(onNext: { [weak mainView] state in
                mainView?.update(message: state.text)
                mainView?.update(계좌종류: state.계좌종류)
            })
            .disposed(by: disposeBag)

        listener?.action(.viewDidLoad)
    }

    @objc func tappedButton(_ sender: UIButton) {
        listener?.action(.applyCheckCard)
    }

    @objc func tappedFinishButton(_ sender: UIButton) {
        listener?.action(.finish)
    }
    @objc func tappedMoveToMainButton(_ sender: UIButton) {
        listener?.action(.moveToMain)
    }
}
