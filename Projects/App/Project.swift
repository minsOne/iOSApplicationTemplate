import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let organizationName = "minsone"
let deploymentTarget: DeploymentTarget = .iOS(targetVersion: "13.0", devices: .iphone)

let settings: Settings =
    .settings(base: ["CODE_SIGN_IDENTITY": "",
                     "CODE_SIGNING_REQUIRED": "NO"],
              configurations: [
                  .debug(name: .dev, xcconfig: .relativeToRoot("XCConfig/App/DevApp-DEV.xcconfig")),
                  .debug(name: .test, xcconfig: .relativeToRoot("XCConfig/App/DevApp-TEST.xcconfig")),
                  .debug(name: .stage, xcconfig: .relativeToRoot("XCConfig/App/DevApp-STAGE.xcconfig")),
                  .release(name: .prod, xcconfig: .relativeToRoot("XCConfig/App/DevApp-PROD.xcconfig")),
                  .debug(name: .dev, xcconfig: .relativeToRoot("XCConfig/App/App-DEV.xcconfig")),
                  .debug(name: .test, xcconfig: .relativeToRoot("XCConfig/App/App-TEST.xcconfig")),
                  .debug(name: .stage, xcconfig: .relativeToRoot("XCConfig/App/App-STAGE.xcconfig")),
                  .release(name: .prod, xcconfig: .relativeToRoot("XCConfig/App/App-PROD.xcconfig")),
              ])

let scripts: [TargetScript] = [
    .pre(path: "Script/matching_google_service_info_plist.sh", name: "Matching GoogleService-Info.plist Script"),
]

let targets: [Target] = [
    .init(name: "App",
          platform: .iOS,
          product: .app,
          productName: "App",
          bundleId: "kr.minsone.app",
          deploymentTarget: deploymentTarget,
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
              .Project.Module.ThirdPartyDynamicLibraryPluginManager,
          ]),
    .init(name: "DevApp",
          platform: .iOS,
          product: .app,
          productName: "dev_app",
          bundleId: "kr.minsone.dev-app",
          deploymentTarget: deploymentTarget,
          infoPlist: .extendingDefault(with: [
              "UIMainStoryboardFile": "",
              "UILaunchStoryboardName": "LaunchScreen",
          ]),
          sources: ["Sources/**", "DevSources/**"],
          resources: ["Resources/**"],
          scripts: scripts,
          dependencies: [
              .Project.Feature.Features,
              .Project.Module.RepositoryInjectManager,
              .Project.Module.DevelopTool,
              .Project.Module.ThirdPartyDynamicLibraryPluginManager,
          ]),
    .init(name: "DevAppTests",
          platform: .iOS,
          product: .unitTests,
          bundleId: "kr.minsone.dev-appTests",
          deploymentTarget: deploymentTarget,
          infoPlist: .default,
          sources: "Tests/**",
          dependencies: [
              .target(name: "DevApp"),
              .Carthage.Quick,
              .Carthage.Nimble,
          ]),
]

let schemes: [Scheme] = [
    .init(name: "DevApp-Develop",
          shared: true,
          buildAction: .buildAction(targets: ["DevApp"]),
          testAction: .targets(["DevAppTests"],
                               configuration: .dev,
                               options: .options(coverage: true)),
          runAction: .runAction(configuration: .dev),
          archiveAction: .archiveAction(configuration: .dev),
          profileAction: .profileAction(configuration: .dev),
          analyzeAction: .analyzeAction(configuration: .dev)),
    .init(name: "App-PROD",
          shared: true,
          buildAction: .buildAction(targets: ["App"]),
          testAction: nil,
          runAction: .runAction(configuration: .prod),
          archiveAction: .archiveAction(configuration: .prod),
          profileAction: .profileAction(configuration: .prod),
          analyzeAction: .analyzeAction(configuration: .prod)),
]

// MARK: - Project

let project: Project =
    .init(name: "App",
          organizationName: organizationName,
          settings: settings,
          targets: targets,
          schemes: schemes)
