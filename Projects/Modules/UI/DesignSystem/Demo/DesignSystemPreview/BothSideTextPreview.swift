//
//  BothSideTextPreview.swift
//  DesignSystemDemoApp
//
//  Created by minsone on 2021/07/21.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import SwiftUI
import DesignSystem
import ResourcePackage

#if  DEBUG
struct Preview1_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 8) {
            SeperateLine.Gray()
            
            BothSideText(title: "계좌종류", detail: "입출금(한도계좌)")
            
            SeperateLine.Gray()
            
            BothSideText(title: "1일 이체한도", detail: "1일 최대 200만원\n1회 최대 200만원")
            
            SeperateLine.Gray()
            
            BothSideText(title: "1회 이체한도", detail: "1회 최대 200만원")
            
            SeperateLine.Gray()
        }
    }
}
#endif
