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
        FrameworkTemplate(name: name,
                          destinations: destinations,
                          deploymentTargets: deploymentTargets,
                          target: target,
                          packages: packages,
                          dependencies: dependencies,
                          uiDependencies: uiDependencies,
                          configure: configure)
            .project
    }
}
