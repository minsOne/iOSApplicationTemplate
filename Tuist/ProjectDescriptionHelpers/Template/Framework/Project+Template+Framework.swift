import Foundation
import ProjectDescription

public extension Project {
    static func framework(name: String,
                          destinations: Destinations = .iOS,
                          deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                          target: [FrameworkTemplate.Target] = [],
                          packages: [Package] = [],
                          dependencies: [TargetDependency] = [],
                          uiDependencies: [TargetDependency] = [],
                          configure: FrameworkTemplate.TargetConfigure = .init()) -> Self {
        typealias Generator = FrameworkTemplateProjectGenerator
        typealias Name = FrameworkTemplateTargetName

        var targetList: [Target] = []
        var schemeList: [Scheme] = []

        let name = Name(name)
        let hasUI = target.uiList.hasUI
        let hasInternalDTO = target.hasInternalDTO
        let packageName = configure.packageName

        let framework = Generator.Framework(
            info: .init(
                name: name,
                hasInternalDTO: hasInternalDTO,
                hasUI: hasUI,
                targets: target.frameworks,
                destinations: destinations,
                deploymentTargets: deploymentTargets,
                configure: configure,
                dependencies: dependencies
            )
        )

        if let framework {
            targetList.append(contentsOf: framework.targets)
            schemeList.append(contentsOf: framework.schemes)
        }

        let ui = Generator.UI(
            info: .init(
                name: name,
                hasInternalDTO: hasInternalDTO,
                targets: target.uiList,
                destinations: destinations,
                deploymentTargets: deploymentTargets,
                packageName: packageName,
                uiDependencies: uiDependencies,
                previewDependencies: configure.ui.preview.dependency
            )
        )

        if let ui {
            targetList.append(contentsOf: ui.targets)
            schemeList.append(contentsOf: ui.schemes)
        }

        if hasInternalDTO {
            let internalDTO = Generator.InternalDTO(
                info: .init(
                    name: name,
                    destinations: destinations,
                    deploymentTargets: deploymentTargets,
                    packageName: packageName
                )
            )

            targetList.append(internalDTO.target)
            schemeList.append(internalDTO.scheme)
        }

        return Generator.Project(
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
