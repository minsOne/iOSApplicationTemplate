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
    .pre(path: "Script/matching_google_service_info_plist.sh",
         name: "Matching GoogleService-Info.plist Script"),
]

let targets: [Target] = [
    .init(name: "iOS_App",
          platform: .iOS,
          product: .app,
          productName: "iOS_App",
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
    .init(name: "iOS_DevApp",
          platform: .iOS,
          product: .app,
          productName: "iOS_DevApp",
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
    .init(name: "iOS_DevAppTests",
          platform: .iOS,
          product: .unitTests,
          bundleId: "kr.minsone.dev-appTests",
          deploymentTarget: deploymentTarget,
          infoPlist: .default,
          sources: "Tests/**",
          dependencies: [
              .target(name: "iOS_DevApp"),
              .Carthage.Quick,
              .Carthage.Nimble,
          ]),
]

let schemes: [Scheme] = [
    .init(name: "iOS_DevApp-Develop",
          shared: true,
          buildAction: .buildAction(targets: ["iOS_DevApp"]),
          testAction: .targets(["iOS_DevAppTests"],
                               configuration: .dev,
                               options: .options(coverage: true)),
          runAction: .runAction(configuration: .dev),
          archiveAction: .archiveAction(configuration: .dev),
          profileAction: .profileAction(configuration: .dev),
          analyzeAction: .analyzeAction(configuration: .dev)),
    .init(name: "iOS_DevApp-Production",
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