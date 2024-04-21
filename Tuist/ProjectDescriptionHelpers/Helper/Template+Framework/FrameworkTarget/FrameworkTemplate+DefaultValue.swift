//
//  FrameworkTemplate+DefaultValue.swift
//  ProjectDescriptionHelpers
//
//  Created by minsOne on 4/15/24.
//

import Foundation
import ProjectDescription

private typealias Template = FrameworkTemplate

// MARK: Default Value

public extension Template {
    enum DefaultValue {
        public enum Settings {}
        public enum Plist {}
        public enum BundleID {}

        public static let organizationName = "minsone"
        public static let deploymentTargets = DeploymentTargets.iOS("14.0")
    }
}

public extension Template.DefaultValue.Settings {
    static let project: SettingsDictionary = [
        "CODE_SIGN_IDENTITY": "",
        "CODE_SIGNING_REQUIRED": "NO",
    ]
}

public extension Template.DefaultValue.Plist {
    static let app: [String: Plist.Value] = [
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen",
    ]
}

public extension Template.DefaultValue.BundleID {
    static let demoApp = "kr.minsone.example.demoApp"
    static let widgetExtension = "kr.minsone.example.demoApp.widgetExtension"
}
