//
//  UIViewControllerPreview.swift
//  DesignSystem
//
//  Created by minsone on 2021/08/22.
//  Copyright © 2021 minsone. All rights reserved.
//

// Reference : https://seokba.tistory.com/11

import Foundation

#if canImport(SwiftUI) && DEBUG
import UIKit
import SwiftUI

// MARK: - Preview for UIView
@available(iOS 13.0, *)
public struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View

    public init(_ builder: @escaping () -> View) {
        view = builder()
    }

    public func makeUIView(context: Context) -> UIView {
        return view
    }

    public func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}

// MARK: - Preview for UIViewController
@available(iOS 13.0, *)
public struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    public let viewController: ViewController

    public init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }

    public func makeUIViewController(context: Context) -> ViewController {
        return viewController
    }

    public func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        viewController.view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        viewController.view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
#endif
