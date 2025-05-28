import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator
private typealias TemplateDTO = FrameworkTemplateProjectDTO

extension TemplateDTO.Framework {
    struct DemoApp {
        struct Info {
            let name: FrameworkTemplateTargetNameSet
            let hasTesting: Bool
            let hasUnitTests: Bool
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let configure: FrameworkTemplate.TargetConfigure
        }

        let target: Target
        let scheme: Scheme

        init(info: Info) {
            let demoAppConfigure = info.configure.demoApp
            var dependencies = demoAppConfigure.dependency
            dependencies += info.hasTesting
                ? [.target(name: info.name.framework.testing)]
                : [.target(name: info.name.framework.module)]
            let bundleId = demoAppConfigure.bundleId
            let unitTestsName = info.hasUnitTests ? info.name.framework.unitTests : nil

            let demoApp = Generator.Framework.DemoApp(
                name: info.name.framework.demoApp,
                destinations: info.destinations,
                deploymentTargets: info.deploymentTargets,
                infoPlist: FrameworkTemplate.DefaultValue.Plist.app,
                dependencies: dependencies,
                bundleId: bundleId,
                unitTestName: unitTestsName
            )
            target = demoApp.target
            scheme = demoApp.scheme
        }
    }
}
