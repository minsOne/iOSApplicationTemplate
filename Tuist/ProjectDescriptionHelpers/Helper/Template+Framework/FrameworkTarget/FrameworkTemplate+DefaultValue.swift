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
    }
}

public extension Template.DefaultValue.Settings {
    static let project: SettingsDictionary = [
        "CODE_SIGN_IDENTITY": "",
        "CODE_SIGNING_REQUIRED": "NO",
    ]
}

public extension Template.DefaultValue.Plist {
    static let demoApp: [String: Plist.Value] = [
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen",
    ]
}
