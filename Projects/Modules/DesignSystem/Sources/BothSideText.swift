//
//  BothSideText.swift
//  DesignSystem
//
//  Created by minsone on 2021/07/18.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import SwiftUI


/// 양쪽으로 Text를 표시하도록 함.
public struct BothSideText: View {
    let title: String
    let detail: String

    public init(title: String, detail: String) {
        self.title = title
        self.detail = detail
    }

    public var body: some View {
        return HStack {
            Text(title)
                .fontWeight(.bold)
            Spacer()
            Text(detail)
                .multilineTextAlignment(.trailing)
                .lineSpacing(7)
        }
        .accessibility(label: Text("\(title) \(detail)"))
    }
}
