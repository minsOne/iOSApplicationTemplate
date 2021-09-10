//
//  FlexLayoutDesignSystem.swift
//  DesignSystem
//
//  Created by minsone on 2021/08/22.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import FlexLayout

extension UIView {
    public struct FlexLayoutDesignSystem {}
}

public extension UIView.FlexLayoutDesignSystem {
    static var line: UIView {
        let view = UIView()
        view.flex.addItem()
            .height(1)
            .backgroundColor(.systemGray)
        return view
    }

    static func bothSideLabel(title: String, info: String) -> BothSideLabelView {
        return BothSideLabelView(title: title, info: info)
    }
}

public class BothSideLabelView {
    private let leftLabel = UILabel()
    private let rightLabel = UILabel()

    public var container = UIView()

    init(title: String, info: String) {
        leftLabel.text = title
        rightLabel.text = info
        rightLabel.textAlignment = .right
        container.flex.direction(.row).alignContent(.spaceBetween)
        container.flex.addItem(leftLabel)
        container.flex.addItem(rightLabel).grow(1)
    }

    public func update(info: String) {
        rightLabel.text = info
    }
}
