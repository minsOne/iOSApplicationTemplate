import ProjectDescription
import UtilityPlugin

extension Project {
    public static
    func app(name: String,
             platform: Platform,
             dependencies: [TargetDependency] = []) -> Self {
        return project(name: name,
                       product: .app,
                       platform: platform,
                       dependencies: dependencies,
                       infoPlist: [
                        "CFBundleShortVersionString": "1.0",
                        "CFBundleVersion": "1"
                       ])
    }
    
    public static
    func staticLibrary(name: String,
                       platform: Platform = .iOS,
                       packages: [Package] = [],
                       dependencies: [TargetDependency] = []) -> Self {
        return project(name: name,
                       packages: packages,
                       product: .staticLibrary,
                       platform: platform,
                       dependencies: dependencies)
    }
    
    public static
    func staticFramework(name: String,
                         platform: Platform = .iOS,
                         packages: [Package] = [],
                         dependencies: [TargetDependency] = []) -> Self {
        return project(name: name,
                       packages: packages,
                       product: .staticFramework,
                       platform: platform,
                       dependencies: dependencies)
    }
    
    public static
    func framework(name: String,
                   platform: Platform = .iOS,
                   packages: [Package] = [],
                   dependencies: [TargetDependency] = []) -> Self {
        return project(name: name,
                       packages: packages,
                       product: .framework,
                       platform: platform,
                       dependencies: dependencies)
    }
}

extension Project {
    public static
    func project(name: String,
                 organizationName: String = "minsone",
                 packages: [Package] = [],
                 product: Product,
                 platform: Platform = .iOS,
                 deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "13.0", devices: .iphone),
                 dependencies: [TargetDependency] = [],
                 infoPlist: [String: InfoPlist.Value] = [:]) -> Project {
        
        let settings = Settings(configurations: [
            .debug(name: "DEV", xcconfig: .relativeToXCConfig(type: .dev, name: name)),
            .debug(name: "TEST", xcconfig: .relativeToXCConfig(type: .test, name: name)),
            .debug(name: "STAGE", xcconfig: .relativeToXCConfig(type: .stage, name: name)),
            .release(name: "PROD", xcconfig: .relativeToXCConfig(type: .prod, name: name)),
        ])
        
        let target1 = Target(name: name,
                             platform: platform,
                             product: product,
                             bundleId: "kr.minsone.\(name)",
                             deploymentTarget: deploymentTarget,
                             infoPlist: .extendingDefault(with: infoPlist),
                             sources: ["Sources/**"],
                             resources: ["Resources/**"],
                             dependencies: dependencies)
        
        let testTarget = Target(name: "\(name)Tests",
                                platform: platform,
                                product: .unitTests,
                                bundleId: "kr.minsone.\(name)Tests",
                                deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
                                infoPlist: .default,
                                sources: "Tests/**",
                                dependencies: [
                                    .target(name: "\(name)")
                                ])
        
        let schemes: [Scheme] = [
            .makeScheme(target: .dev, name: name),
        ]
        
        return Project(name: name,
                       organizationName: "minsone",
                       packages: packages,
                       settings: settings,
                       targets: [
                        target1,
                        testTarget
                       ],
                       schemes: schemes)
    }
    
}

public extension Scheme {
    static func makeScheme(target: ProjectDeployTarget, name: String) -> Self {
        return Scheme(name: "Default-\(name)",
                      shared: true,
                      buildAction: BuildAction(targets: ["\(name)"]),
                      testAction: TestAction(targets: ["\(name)Tests"],
                                             configurationName: target.rawValue,
                                             coverage: true),
                      runAction: RunAction(configurationName: target.rawValue),
                      archiveAction: ArchiveAction(configurationName: target.rawValue),
                      profileAction: ProfileAction(configurationName: target.rawValue),
                      analyzeAction: AnalyzeAction(configurationName: target.rawValue))
    }
}
