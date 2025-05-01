import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator
private typealias TemplateDTO = FrameworkTemplateProjectDTO

extension TemplateDTO.Framework {
    struct UnitTests {
        struct Info {
            let name: FrameworkTemplateTargetName
            let hasTesting: Bool
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let configure: FrameworkTemplate.TargetConfigure
        }

        let target: Target
        init(info: Info) {
            var dependencies = info.configure.testing.dependency
            dependencies += [.SwiftPM.Test.Stub]
            dependencies += info.hasTesting
                ? [.target(name: info.name.framework.testing)]
                : [.target(name: info.name.framework.module)]

            let unitTests = Generator.Framework.UnitTests(
                name: info.name.framework.unitTests,
                destinations: info.destinations,
                deploymentTargets: info.deploymentTargets,
                dependencies: dependencies
            )
            target = unitTests.target
        }
    }
}
