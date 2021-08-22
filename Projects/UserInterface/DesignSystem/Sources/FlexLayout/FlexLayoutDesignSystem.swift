//
//  FlexLayoutDesignSystem.swift
//  DesignSystem
//
//  Created by minsone on 2021/08/22.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import FlexLayout

public struct FlexLayoutDesignSystem {
    public static func line() -> UIView {
        let view = UIView()
        view.flex.addItem()
            .height(1)
            .backgroundColor(.systemGray)
        return view
    }

    public static func bothSideLabel(title: String, info: String) -> UIView {
        let container = UIView()
        let label1 = UILabel()
        let label2 = UILabel()
        label1.text = title
        label2.text = info
        label2.textAlignment = .right
        container.flex.direction(.row).alignContent(.spaceBetween)
        container.flex.addItem(label1)
        container.flex.addItem(label2).grow(1)
        return container
    }
}
