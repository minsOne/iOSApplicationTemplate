//
//  DeployTarget.swift
//  LocalPlugin
//
//  Created by minsone on 2021/05/15.
//

import Foundation
import ProjectDescription

public enum ProjectDeployTarget: String {
    case dev = "DEV"
    case test = "TEST"
    case stage = "STAGE"
    case prod = "PROD"

    public var configuration: ConfigurationName {
        .configuration(rawValue)
    }
}
