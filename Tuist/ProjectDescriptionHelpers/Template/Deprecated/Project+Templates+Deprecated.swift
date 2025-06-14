import ProjectDescription

private extension Project {
    static func deprecatedProject(name: String,
                                  organizationName _: String = "minsone",
                                  packages: [Package] = [],
                                  product: Product,
                                  platform _: Platform = .iOS,
                                  deploymentTarget: DeploymentTargets? = .default,
                                  dependencies: [TargetDependency] = [],
                                  infoPlist: [String: Plist.Value] = [:],
                                  hasDemoApp: Bool = false) -> Project
    {
        let organizationName = "minsone"
        let settings: Settings = .settings(base: ["CODE_SIGN_IDENTITY": "",
                                                  "CODE_SIGNING_REQUIRED": "NO"],
                                           configurations: [
                                               .debug(name: .dev, xcconfig: .moduleXCConfig(type: .dev)),
                                               .debug(name: .test, xcconfig: .moduleXCConfig(type: .test)),
                                               .release(name: .qa, xcconfig: .moduleXCConfig(type: .qa)),
                                               .release(name: .stage, xcconfig: .moduleXCConfig(type: .stage)),
                                               .release(name: .prod, xcconfig: .moduleXCConfig(type: .prod))
                                           ])

        let target1 = Target.target(name: name,
                                    destinations: .iOS,
                                    product: product,
                                    bundleId: "kr.minsone.\(name)",
                                    deploymentTargets: deploymentTarget,
                                    infoPlist: .extendingDefault(with: infoPlist),
                                    sources: ["Sources/**"],
//                                    resources: ["Resources/**"],
                                    dependencies: dependencies)

        let demoAppTarget = Target.target(name: "\(name)DemoApp",
                                          destinations: .iOS,
                                          product: .app,
                                          bundleId: "kr.minsone.\(name)DemoApp",
                                          deploymentTargets: deploymentTarget,
                                          infoPlist: .extendingDefault(with: [
                                              "UIMainStoryboardFile": "",
                                              "UILaunchStoryboardName": "LaunchScreen"
                                          ]),
                                          sources: ["Demo/**"],
                                          resources: ["Demo/Resources/**"],
                                          dependencies: [
                                              .target(name: "\(name)")
                                          ])

        let testTargetDependencies: [TargetDependency] = hasDemoApp
            ? [.target(name: "\(name)DemoApp")]
            : [.target(name: "\(name)")]
        let testTarget = Target.target(name: "\(name)Tests",
                                       destinations: .iOS,
                                       product: .unitTests,
                                       bundleId: "kr.minsone.\(name)Tests",
                                       deploymentTargets: deploymentTarget,
                                       infoPlist: .default,
                                       sources: "Tests/**",
                                       dependencies: testTargetDependencies)

        let schemes: [Scheme] = hasDemoApp
            ? [.makeScheme(target: .dev, name: name),
               .makeDemoScheme(target: .dev, name: name)]
            : [.makeScheme(target: .dev, name: name)]

        let targets: [Target] = hasDemoApp
            ? [target1, testTarget, demoAppTarget]
            : [target1, testTarget]

        return Project(name: name,
                       organizationName: organizationName,
                       packages: packages,
                       settings: settings,
                       targets: targets,
                       schemes: schemes,
                       additionalFiles: [
                           .glob(pattern: "README.md"),
                           .glob(pattern: "Project.swift")
                       ])
    }
}

private extension Scheme {
    static func makeScheme(target: AppConfiguration, name: String) -> Self {
        scheme(name: "\(name)",
               shared: true,
               buildAction: .buildAction(targets: ["\(name)"]),
               testAction: .targets(["\(name)Tests"],
                                    arguments: nil,
                                    configuration: target.configurationName,
                                    options: .options(coverage: true)),
               runAction: .runAction(configuration: target.configurationName),
               archiveAction: .archiveAction(configuration: target.configurationName),
               profileAction: .profileAction(configuration: target.configurationName),
               analyzeAction: .analyzeAction(configuration: target.configurationName))
    }

    static func makeDemoScheme(target: AppConfiguration, name: String) -> Self {
        scheme(name: "\(name)DemoApp",
               shared: true,
               buildAction: .buildAction(targets: ["\(name)DemoApp"]),
               testAction: .targets(["\(name)Tests"],
                                    arguments: nil,
                                    configuration: target.configurationName,
                                    options: .options(coverage: true)),
               runAction: .runAction(configuration: target.configurationName),
               archiveAction: .archiveAction(configuration: target.configurationName),
               profileAction: .profileAction(configuration: target.configurationName),
               analyzeAction: .analyzeAction(configuration: target.configurationName))
    }
}
