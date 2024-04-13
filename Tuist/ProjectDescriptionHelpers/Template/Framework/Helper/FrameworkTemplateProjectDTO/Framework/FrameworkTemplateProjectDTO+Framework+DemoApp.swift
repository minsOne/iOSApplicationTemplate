import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator
private typealias TemplateDTO = FrameworkTemplateProjectDTO

extension TemplateDTO.Framework {
    struct DemoApp {
        struct Info {
            let name: FrameworkTemplateTargetName
            let hasTesting: Bool
            let hasUnitTests: Bool
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let configure: FrameworkTemplate.TargetConfigure
        }

        let target: Target
        let scheme: Scheme

        init(info: Info) {
            let demoAppConfigure = info.configure.framework.demoApp
            var dependencies = demoAppConfigure.dependency
            dependencies += info.hasTesting
                ? [.target(name: info.name.framework.testing)]
                : [.target(name: info.name.framework.module)]
            let bundleId = demoAppConfigure.bundleId
            let unitTestsName = info.hasUnitTests ? info.name.framework.unitTests : nil
            let infoPlist: [String: Plist.Value] = [
                "UIMainStoryboardFile": "",
                "UILaunchStoryboardName": "LaunchScreen",
            ]

            let demoApp = Generator.Framework.DemoApp(
                name: info.name.framework.demoApp,
                destinations: info.destinations,
                deploymentTargets: info.deploymentTargets,
                infoPlist: infoPlist,
                dependencies: dependencies,
                bundleId: bundleId,
                unitTestName: unitTestsName
            )
            target = demoApp.target
            scheme = demoApp.scheme
        }
    }
}
