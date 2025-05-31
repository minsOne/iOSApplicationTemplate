import ProjectDescription
import ProjectDescriptionHelpers

enum ProductName {
    static let releaseApp = "iOS_App"
    static let devApp = "iOS_DevApp"
    static let unitTest = "iOS_UnitTests"
}

let settings: Settings =
    .settings(base: FrameworkTemplate.DefaultValue.Settings.project,
              configurations: [
                  .debug(name: .dev, xcconfig: XCConfig.Application.devApp(.dev)),
                  .debug(name: .test, xcconfig: XCConfig.Application.devApp(.test)),
                  .release(name: .qa, xcconfig: XCConfig.Application.devApp(.qa)),
                  .release(name: .stage, xcconfig: XCConfig.Application.app(.stage)),
                  .release(name: .prod, xcconfig: XCConfig.Application.app(.prod)),
              ])

let scripts: [TargetScript] = [
    .pre(path: "Script/matching_google_service_info_plist.sh",
         name: "Matching GoogleService-Info.plist Script"),
]

let targets: [Target] = [
    .target(name: ProductName.releaseApp,
            destinations: .iOS,
            product: .app,
            productName: ProductName.releaseApp,
            bundleId: "kr.minsone.app",
            deploymentTargets: .default,
            infoPlist: .extendingDefault(with: FrameworkTemplate.DefaultValue.Plist.app),
            sources: [.glob("Sources/**/*.swift",
                            excluding: "Sources/Dev/**")],
            resources: [.glob(pattern: "Resources/**",
                              excluding: ["Resources/Dev/**"])],
            scripts: scripts,
            dependencies: [
                .Project.Feature.Features,
            ]),
    .target(name: ProductName.devApp,
            destinations: .iOS,
            product: .app,
            productName: ProductName.releaseApp,
            bundleId: "kr.minsone.devApp",
            deploymentTargets: .default,
            infoPlist: .extendingDefault(with: FrameworkTemplate.DefaultValue.Plist.app),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            scripts: scripts,
            dependencies: [
                .Project.Feature.Features,
                .Project.Module.DevelopTool,
            ]),
    .target(name: ProductName.unitTest,
            destinations: .iOS,
            product: .unitTests,
            bundleId: "kr.minsone.devAppUnitTests",
            deploymentTargets: .default,
            infoPlist: .default,
            sources: "Tests/**",
            dependencies: [
                .target(name: ProductName.devApp),
            ]),
]

let schemes: [Scheme] = [
    .scheme(name: ProductName.devApp,
            shared: true,
            buildAction: .buildAction(targets: ["\(ProductName.devApp)"]),
            testAction: .targets(["\(ProductName.unitTest)"],
                                 configuration: .dev,
                                 options: .options(coverage: true)),
            runAction: .runAction(configuration: .dev),
            archiveAction: .archiveAction(configuration: .dev),
            profileAction: .profileAction(configuration: .dev),
            analyzeAction: .analyzeAction(configuration: .dev)),
    .scheme(name: ProductName.releaseApp,
            shared: true,
            buildAction: .buildAction(targets: ["\(ProductName.releaseApp)"]),
            testAction: nil,
            runAction: .runAction(configuration: .prod),
            archiveAction: .archiveAction(configuration: .prod),
            profileAction: .profileAction(configuration: .prod),
            analyzeAction: .analyzeAction(configuration: .prod)),
]

// MARK: - Project

let project: Project =
    .init(name: "Application",
          organizationName: Misc.organizationName,
          settings: settings,
          targets: targets,
          schemes: schemes)
