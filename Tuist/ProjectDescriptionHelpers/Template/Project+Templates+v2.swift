import Foundation
import ProjectDescription

public extension Project {
    static func framework(name: String,
                          platform: Platform = .iOS,
                          target: Set<FrameworkTemplate.Target> = [],
                          packages: [Package] = [],
                          dependencies: Set<FrameworkTemplate.Dependency> = [],
                          configure: Set<FrameworkTemplate.TargetConfigure>) -> Self
    {
        return () as! Self
    }
}

// MARK: Make Framework Target

private extension Project {
    enum MachO {
        case `static`, dynamic
    }

    func makeFrameworkModule(name: String,
                             macho: MachO,
                             destinations: Destinations = .iOS,
                             deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                             infoPlist: [String: Plist.Value] = [:],
                             dependencies: [TargetDependency] = [],
                             hiddenScheme: Bool = false,
                             unitTestName: String? = nil) -> (Target, Scheme)
    {
        let product: Product
        let resources: ResourceFileElements?
        var testAction: TestAction?

        switch macho {
        case .static:
            product = .staticLibrary
            resources = nil
        case .dynamic:
            product = .framework
            resources = nil
        }
        if let unitTestName {
            testAction = .targets(["\(unitTestName)"],
                                  configuration: .dev,
                                  options: .options(coverage: true))
        }

        let bundleId = BundleIdGenerator().generate(name: name)
        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: product,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["Sources/Framework/Module/**"],
                                   resources: resources,
                                   dependencies: dependencies,
                                   settings: nil)

        let scheme = Scheme.scheme(name: name,
                                   shared: true,
                                   hidden: hiddenScheme,
                                   buildAction: .buildAction(targets: ["\(name)"]),
                                   testAction: testAction,
                                   runAction: .runAction(configuration: .dev),
                                   archiveAction: .archiveAction(configuration: .dev),
                                   profileAction: .profileAction(configuration: .dev),
                                   analyzeAction: .analyzeAction(configuration: .dev))

        return (target, scheme)
    }

    func makeFrameworkTesting(name: String,
                              destinations: Destinations = .iOS,
                              deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                              infoPlist: [String: Plist.Value] = [:],
                              dependencies: [TargetDependency] = []) -> (Target, Scheme)
    {
        let bundleId = BundleIdGenerator().generate(name: name)
        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .staticLibrary,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["Sources/Framework/Testing/**"],
                                   dependencies: dependencies,
                                   settings: nil)

        let scheme = Scheme.scheme(name: name,
                                   shared: true,
                                   hidden: true,
                                   buildAction: .buildAction(targets: ["\(name)"]),
                                   runAction: .runAction(configuration: .dev),
                                   archiveAction: .archiveAction(configuration: .dev),
                                   profileAction: .profileAction(configuration: .dev),
                                   analyzeAction: .analyzeAction(configuration: .dev))

        return (target, scheme)
    }

    func makeFrameworkDemoApp(name: String,
                              destinations: Destinations = .iOS,
                              deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                              infoPlist: [String: Plist.Value] = [:],
                              dependencies: [TargetDependency] = [],
                              bundleId: String? = nil,
                              environmentVariables: [String: EnvironmentVariable] = [:],
                              launchArguments: [LaunchArgument] = [],
                              unitTestName: String? = nil) -> (Target, Scheme)
    {
        let bundleId = bundleId ?? BundleIdGenerator().defaultDemoAppBundleId
        var testAction: TestAction?
        if let unitTestName {
            testAction = .targets(["\(unitTestName)"],
                                  configuration: .dev,
                                  options: .options(coverage: true))
        }

        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .app,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["App/DemoApp/Sources/**"],
                                   resources: ["App/DemoApp/Resources/**"],
                                   dependencies: dependencies,
                                   settings: nil,
                                   environmentVariables: environmentVariables,
                                   launchArguments: launchArguments)

        let scheme = Scheme.scheme(name: name,
                                   shared: true,
                                   hidden: true,
                                   buildAction: .buildAction(targets: ["\(name)"]),
                                   testAction: testAction,
                                   runAction: .runAction(configuration: .dev),
                                   archiveAction: .archiveAction(configuration: .dev),
                                   profileAction: .profileAction(configuration: .dev),
                                   analyzeAction: .analyzeAction(configuration: .dev))

        return (target, scheme)
    }

    func makeFrameworkUnitTests(name: String,
                                destinations: Destinations = .iOS,
                                deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                                infoPlist: [String: Plist.Value] = [:],
                                dependencies: [TargetDependency] = []) -> Target
    {
        let bundleId = BundleIdGenerator().generate(name: name)

        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .unitTests,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .default,
                                   sources: ["Tests/UnitTests/**"],
                                   dependencies: dependencies)

        return target
    }
}

// MARK: Make UI Target

private extension Project {
    func makeUIModule(name: String,
                      destinations: Destinations = .iOS,
                      deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                      infoPlist: [String: Plist.Value] = [:],
                      dependencies: [TargetDependency] = []) -> (Target, Scheme)
    {
        let bundleId = BundleIdGenerator().generate(name: name)

        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .staticLibrary,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["Sources/UI/**"],
                                   dependencies: dependencies,
                                   settings: nil)
        let scheme = Scheme.scheme(name: name,
                                   shared: true,
                                   hidden: true,
                                   buildAction: .buildAction(targets: ["\(name)"]),
                                   testAction: nil,
                                   runAction: .runAction(configuration: .dev),
                                   archiveAction: .archiveAction(configuration: .dev),
                                   profileAction: .profileAction(configuration: .dev),
                                   analyzeAction: .analyzeAction(configuration: .dev))

        return (target, scheme)
    }

    func makeUIPreview(name: String,
                       destinations: Destinations = .iOS,
                       deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                       infoPlist: [String: Plist.Value],
                       dependencies: [TargetDependency] = []) -> (Target, Scheme)
    {
        let bundleId = BundleIdGenerator().generate(name: name)

        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .framework,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .extendingDefault(with: infoPlist),
                                   sources: ["Sources/UIPreview/**"],
                                   dependencies: dependencies,
                                   settings: nil)
        let scheme = Scheme.scheme(name: name,
                                   shared: true,
                                   hidden: true,
                                   buildAction: .buildAction(targets: ["\(name)"]),
                                   testAction: nil,
                                   runAction: .runAction(configuration: .dev),
                                   archiveAction: .archiveAction(configuration: .dev),
                                   profileAction: .profileAction(configuration: .dev),
                                   analyzeAction: .analyzeAction(configuration: .dev))

        return (target, scheme)
    }
}

// MARK: Make InternalDTO Target

private extension Project {
    func makeInternalDTOTarget(name: String,
                               destinations: Destinations = .iOS,
                               deploymentTargets: DeploymentTargets = AppInfo.deploymentTargets,
                               dependencies: [TargetDependency] = []) -> (Target, Scheme)
    {
        let bundleId = BundleIdGenerator().generate(name: name)

        let target = Target.target(name: name,
                                   destinations: destinations,
                                   product: .staticLibrary,
                                   productName: name,
                                   bundleId: bundleId,
                                   deploymentTargets: deploymentTargets,
                                   infoPlist: .default,
                                   sources: ["Sources/InternalDTO/**"],
                                   settings: nil)
        let scheme = Scheme.scheme(name: name,
                                   shared: true,
                                   hidden: true,
                                   buildAction: .buildAction(targets: ["\(name)"]),
                                   testAction: nil,
                                   runAction: .runAction(configuration: .dev),
                                   archiveAction: .archiveAction(configuration: .dev),
                                   profileAction: .profileAction(configuration: .dev),
                                   analyzeAction: .analyzeAction(configuration: .dev))

        return (target, scheme)
    }
}
