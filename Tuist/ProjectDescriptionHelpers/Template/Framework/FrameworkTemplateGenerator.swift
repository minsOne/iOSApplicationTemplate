//
//  FrameworkTemplateGenerator.swift
//  ProjectDescriptionHelpers
//
//  Created by minsOne on 4/13/24.
//

import Foundation
import ProjectDescription

public struct FrameworkTemplate {
    public let project: Project

    public init(name: String,
                destinations: Destinations = .iOS,
                deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                target: [Target] = [],
                packages: [Package] = [],
                dependencies: [TargetDependency] = [],
                uiDependencies: [TargetDependency] = [],
                configure: TargetConfigure = .init()) {
        typealias Generator = FrameworkTemplateProjectDTO
        typealias Name = FrameworkTemplateTargetName

        var targetList: [ProjectDescription.Target] = []
        var schemeList: [ProjectDescription.Scheme] = []

        let name = Name(name)
        let hasUI = target.uiList.hasUI
        let hasInternalDTO = target.hasInternalDTO
        let packageName = configure.packageName
        let needResources = configure.framework.module.needResources

        Generator.Framework(
            info: .init(
                name: name,
                hasInternalDTO: hasInternalDTO,
                hasUI: hasUI,
                targets: target.frameworks,
                destinations: destinations,
                deploymentTargets: deploymentTargets,
                configure: configure,
                dependencies: dependencies,
                needResources: needResources
            ))
            ||> {
                targetList.append(contentsOf: $0.targets)
                schemeList.append(contentsOf: $0.schemes)
            }

        Generator.UI(
            info: .init(
                name: name,
                hasInternalDTO: hasInternalDTO,
                targets: target.uiList,
                destinations: destinations,
                deploymentTargets: deploymentTargets,
                uiDependencies: uiDependencies,
                previewDependencies: configure.ui.preview.dependency
            ))
            ||> {
                targetList.append(contentsOf: $0.targets)
                schemeList.append(contentsOf: $0.schemes)
            }

        (hasInternalDTO
            ?> Generator.InternalDTO(
                info: .init(
                    name: name,
                    destinations: destinations,
                    deploymentTargets: deploymentTargets
                )
            ))
            ||> {
                targetList.append($0.target)
                schemeList.append($0.scheme)
            }

        project = Generator.Project(
            info: .init(
                name: name.project,
                packages: packages,
                targets: targetList,
                schemes: schemeList,
                packageName: packageName
            )
        ).rawValue
    }
}
