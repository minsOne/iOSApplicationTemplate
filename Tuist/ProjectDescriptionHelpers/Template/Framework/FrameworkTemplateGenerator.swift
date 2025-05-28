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
                organizationName: String = "minsone",
                packages: [Package] = [],
                destinations: Destinations = .iOS,
                deploymentTargets: DeploymentTargets = .default,
                target: [Target] = [],
                configure: TargetConfigure = .init())
    {
        typealias Generator = FrameworkTemplateProjectDTO
        typealias Name = FrameworkTemplateTargetNameSet

        var targetList: [ProjectDescription.Target] = []
        var schemeList: [ProjectDescription.Scheme] = []

        let name = Name(name)
        let hasInterface = target.hasInterface
        let hasUI = target.uiList.hasUI
        let hasInternalDTO = target.hasInternalDTO
        let hasMock = target.hasMock
        let packageName = configure.packageName

        if hasInterface {
            Generator.Interface(
                info: .init(
                    name: name,
                    destinations: destinations,
                    deploymentTargets: deploymentTargets,
                    dependencies: configure.interface.dependency
                )
            ) ||> {
                targetList.append(contentsOf: $0.targets)
                schemeList.append(contentsOf: $0.schemes)
            }
        }
        
        if hasMock, hasInterface {
            Generator.Mock(
                info: .init(
                    name: name,
                    destinations: destinations,
                    deploymentTargets: deploymentTargets,
                    dependencies: configure.interface.dependency
                )
            ) ||> {
                targetList.append(contentsOf: $0.targets)
                schemeList.append(contentsOf: $0.schemes)
            }
        }

        Generator.Framework(
            info: .init(
                name: name,
                hasInterface: hasInterface,
                hasInternalDTO: hasInternalDTO,
                hasUI: hasUI,
                targets: target.frameworks,
                destinations: destinations,
                deploymentTargets: deploymentTargets,
                configure: configure
            )) ||> {
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
                configure: configure
            )) ||> {
            targetList.append(contentsOf: $0.targets)
            schemeList.append(contentsOf: $0.schemes)
        }

        if hasInternalDTO {
            Generator.InternalDTO(
                info: .init(
                    name: name,
                    destinations: destinations,
                    deploymentTargets: deploymentTargets
                )
            ) ||> {
                targetList.append($0.target)
                schemeList.append($0.scheme)
            }
        }

        let packages = [
            packages,
            [.Test.MockingKit]
        ].flatMap { $0 }

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
