//
//  SeperateLine.swift
//  DesignSystemDemoApp
//
//  Created by minsone on 2021/07/21.
//  Copyright © 2021 minsone. All rights reserved.
//

import SwiftUI

public struct SeperateLine {
    public struct Gray: View {
        public init() {}
        public var body: some View {
            Color.gray.frame(height: lineHeight)
        }
    }
}
