import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let organizationName = "minsone"
let deploymentTargets = DeploymentTargets.iOS("13.0")
let productName = "iOS_App"

let settings: Settings =
    .settings(base: ["CODE_SIGN_IDENTITY": "",
                     "CODE_SIGNING_REQUIRED": "NO"],
              configurations: [
                  .debug(name: .dev, xcconfig: XCConfig.Application.devApp(.dev)),
                  .debug(name: .test, xcconfig: XCConfig.Application.devApp(.test)),
                  .release(name: .stage, xcconfig: XCConfig.Application.devApp(.stage)),
                  .release(name: .prod, xcconfig: XCConfig.Application.devApp(.prod)),
                  .debug(name: .dev, xcconfig: XCConfig.Application.app(.dev)),
                  .debug(name: .test, xcconfig: XCConfig.Application.app(.test)),
                  .release(name: .stage, xcconfig: XCConfig.Application.app(.stage)),
                  .release(name: .prod, xcconfig: XCConfig.Application.app(.prod)),
              ])

let scripts: [TargetScript] = [
    .pre(path: "Script/matching_google_service_info_plist.sh",
         name: "Matching GoogleService-Info.plist Script"),
]

let targets: [Target] = [
    .target(name: productName,
            destinations: .iOS,
            product: .app,
            productName: productName,
            bundleId: "kr.minsone.app",
            deploymentTargets: deploymentTargets,
            infoPlist: .extendingDefault(with: [
                "UIMainStoryboardFile": "",
                "UILaunchStoryboardName": "LaunchScreen",
            ]),
            sources: [.glob("Sources/**/*.swift", excluding: "Sources/Dev/**")],
            resources: [.glob(pattern: "Resources/**", excluding: ["Resources/Dev/**"])],
            scripts: scripts,
            dependencies: [
                .Project.Feature.Features,
                .Project.Module.RepositoryInjectManager,
                .Project.Module.ThirdPartyDynamicLibraryPluginManager,
            ]),
    .target(name: "iOS_DevApp",
            destinations: .iOS,
            product: .app,
            productName: productName,
            bundleId: "kr.minsone.devApp",
            deploymentTargets: deploymentTargets,
            infoPlist: .extendingDefault(with: [
                "UIMainStoryboardFile": "",
                "UILaunchStoryboardName": "LaunchScreen",
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: scripts,
            dependencies: [
                .Project.Feature.Features,
                .Project.Module.RepositoryInjectManager,
                .Project.Module.DevelopTool,
                .Project.Module.ThirdPartyDynamicLibraryPluginManager,
            ]),
    .target(name: "iOS_UnitTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "kr.minsone.devAppUnitTests",
            deploymentTargets: deploymentTargets,
            infoPlist: .default,
            sources: "Tests/**",
            dependencies: [
                .target(name: "iOS_DevApp"),
                .Carthage.Quick,
                .Carthage.Nimble,
            ]),
]

let schemes: [Scheme] = [
    .scheme(name: "iOS_DevApp",
            shared: true,
            buildAction: .buildAction(targets: ["iOS_DevApp"]),
            testAction: .targets(["iOS_DevAppTests"],
                                 configuration: .dev,
                                 options: .options(coverage: true)),
            runAction: .runAction(configuration: .dev),
            archiveAction: .archiveAction(configuration: .dev),
            profileAction: .profileAction(configuration: .dev),
            analyzeAction: .analyzeAction(configuration: .dev)),
    .scheme(name: "iOS_App",
            shared: true,
            buildAction: .buildAction(targets: ["iOS_App"]),
            testAction: nil,
            runAction: .runAction(configuration: .prod),
            archiveAction: .archiveAction(configuration: .prod),
            profileAction: .profileAction(configuration: .prod),
            analyzeAction: .analyzeAction(configuration: .prod)),
]

// MARK: - Project

let project: Project =
    .init(name: "Application",
          organizationName: organizationName,
          settings: settings,
          targets: targets,
          schemes: schemes)
