import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let organizationName = "minsone"
let deploymentTarget: DeploymentTarget = .iOS(targetVersion: "13.0", devices: .iphone)

let settings: Settings =
    .init(base: ["CODE_SIGN_IDENTITY": "",
                 "CODE_SIGNING_REQUIRED": "NO"],
          configurations: [
            .debug(name: .dev,    xcconfig: .relativeToRoot("XCConfig/App/DevApp-DEV.xcconfig")),
            .debug(name: .test,   xcconfig: .relativeToRoot("XCConfig/App/DevApp-TEST.xcconfig")),
            .debug(name: .stage,  xcconfig: .relativeToRoot("XCConfig/App/DevApp-STAGE.xcconfig")),
            .release(name: .prod, xcconfig: .relativeToRoot("XCConfig/App/DevApp-PROD.xcconfig")),
            .debug(name: .dev,    xcconfig: .relativeToRoot("XCConfig/App/App-DEV.xcconfig")),
            .debug(name: .test,   xcconfig: .relativeToRoot("XCConfig/App/App-TEST.xcconfig")),
            .debug(name: .stage,  xcconfig: .relativeToRoot("XCConfig/App/App-STAGE.xcconfig")),
            .release(name: .prod, xcconfig: .relativeToRoot("XCConfig/App/App-PROD.xcconfig")),
          ])

let targets: [Target] = [
    .init(name: "App",
          platform: .iOS,
          product: .app,
          productName: "App",
          bundleId: "kr.minsone.app",
          deploymentTarget: deploymentTarget,
          infoPlist: .default,
          sources: ["Sources/**"],
          resources: ["Resources/**"],
          dependencies: [
            .Project.coreKit
          ]),
    .init(name: "DevApp",
          platform: .iOS,
          product: .app,
          productName: "dev_app",
          bundleId: "kr.minsone.dev-app",
          deploymentTarget: deploymentTarget,
          infoPlist: .default,
          sources: ["Sources/**", "Dev_Sources/**"],
          resources: ["Resources/**"],
          dependencies: [
            .Project.coreKit
          ]),
    .init(name: "DevAppTests",
          platform: .iOS,
          product: .unitTests,
          bundleId: "kr.minsone.dev-appTests",
          deploymentTarget: deploymentTarget,
          infoPlist: .default,
          sources: "Tests/**",
          dependencies: [.target(name: "DevApp")]),
]

let schemes: [Scheme] = [
    .init(name: "DevApp-Dev",
          shared: true,
          buildAction: BuildAction(targets: ["DevApp"]),
          testAction: TestAction(targets: ["DevAppTests"],
                                 configurationName: "DEV",
                                 coverage: true),
          runAction: RunAction(configurationName: .dev),
          archiveAction: ArchiveAction(configurationName: .dev),
          profileAction: ProfileAction(configurationName: .dev),
          analyzeAction: AnalyzeAction(configurationName: .dev)),
    .init(name: "App-PROD",
          shared: true,
          buildAction: BuildAction(targets: ["App"]),
          testAction: nil,
          runAction: RunAction(configurationName: .prod),
          archiveAction: ArchiveAction(configurationName: .prod),
          profileAction: ProfileAction(configurationName: .prod),
          analyzeAction: AnalyzeAction(configurationName: .prod)),
]

// MARK: - Project

let project: Project =
    .init(name: "App",
          organizationName: organizationName,
          settings: settings,
          targets: targets,
          schemes: schemes)









// MARK: - Util
private extension String {
    static var dev: String    { ProjectDeployTarget.dev.rawValue }
    static var test: String   { ProjectDeployTarget.test.rawValue }
    static var stage: String  { ProjectDeployTarget.stage.rawValue }
    static var prod: String   { ProjectDeployTarget.prod.rawValue }
}
