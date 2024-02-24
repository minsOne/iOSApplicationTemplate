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
        var targetList: [Target] = []
        var schemeList: [Scheme] = []

        let name = Name(name)

        let module_macho = target.module
        let hasModule = module_macho != nil
        let hasUI = target.hasUI
        let hasInternalDTO = target.hasInternalDTO
        let packageName = configure.framework.module.packageName

        if hasModule, let module_macho {
            let (targets, schemes) = makeFrameworkTargets(
                name: name,
                hasInternalDTO: hasInternalDTO,
                hasUI: hasUI,
                macho: module_macho,
                target: target,
                destinations: destinations,
                deploymentTargets: deploymentTargets,
                packageName: packageName,
                configure: configure,
                dependencies: dependencies
            )
            targetList.append(contentsOf: targets)
            schemeList.append(contentsOf: schemes)
        }

        if hasUI {
            let (targets, schemes) = makeUITargets(
                name: name,
                hasInternalDTO: hasInternalDTO,
                hasUIPreview: target.hasUIPreview,
                destinations: destinations,
                deploymentTargets: deploymentTargets,
                packageName: packageName,
                uiDependencies: uiDependencies,
                previewDependencies: configure.ui.preview.dependency
            )
            targetList.append(contentsOf: targets)
            schemeList.append(contentsOf: schemes)
        }

        if hasInternalDTO {
            let (target, scheme) = makeInternalDTOTarget(
                name: name,
                destinations: destinations,
                deploymentTargets: deploymentTargets,
                packageName: packageName
            )
            targetList.append(target)
            schemeList.append(scheme)
        }

        return Generator.project(name: name.project,
                                 packages: packages,
                                 targets: targetList,
                                 schemes: schemeList)
    }
}

// MARK: Framework

private extension Project {
    static func makeFrameworkTargets(name: Name,
                                     hasInternalDTO: Bool,
                                     hasUI: Bool,
                                     macho: FrameworkTemplate.Target.Framework.MachO,
                                     target: [FrameworkTemplate.Target],
                                     destinations: Destinations,
                                     deploymentTargets: DeploymentTargets,
                                     packageName: String?,
                                     configure: FrameworkTemplate.TargetConfigure,
                                     dependencies: [TargetDependency]) -> ([Target], [Scheme]) {
        var targets: [Target] = []
        var schemes: [Scheme] = []

        let hasTesting = target.hasTesting
        let hasDemoApp = target.hasDemoApp
        let hasUnitTests = target.hasUnitTests

        func makeModule(macho: FrameworkTemplate.Target.Framework.MachO) {
            let macho: Generator.MachO = switch macho {
            case .dynamic: .dynamic
            case .static: .static
            }
            let isHiddenScheme = configure.framework.module.isHiddenScheme
            let unitTestsName = hasUnitTests ? name.framework.unitTests : nil
            var dependencies = dependencies
            if hasUI {
                dependencies.append(.target(name: name.ui.module))
            }
            if hasInternalDTO {
                dependencies.append(.target(name: name.internalDTO))
            }

            let (target, scheme) =
                Generator.frameworkModule(name: name.framework.module,
                                          macho: macho,
                                          destinations: destinations,
                                          deploymentTargets: deploymentTargets,
                                          dependencies: dependencies,
                                          hiddenScheme: isHiddenScheme,
                                          unitTestsName: unitTestsName,
                                          packageName: packageName)
            targets.append(target)
            schemes.append(scheme)
        }

        func makeTesting() {
            var dependencies = configure.framework.testing.dependency
            dependencies.append(.target(name: name.framework.module))

            let (target, scheme) =
                Generator.frameworkTesting(name: name.framework.testing,
                                           destinations: destinations,
                                           deploymentTargets: deploymentTargets,
                                           dependencies: dependencies,
                                           packageName: packageName)
            targets.append(target)
            schemes.append(scheme)
        }

        func makeDemoApp() {
            let demoAppConfigure = configure.framework.demoApp
            var dependencies = demoAppConfigure.dependency
            dependencies += hasTesting
                ? [.target(name: name.framework.testing)]
                : [.target(name: name.framework.module)]
            let bundleId = demoAppConfigure.bundleId
            let unitTestsName = hasUnitTests ? name.framework.unitTests : nil
            let infoPlist: [String: Plist.Value] = [
                "UIMainStoryboardFile": "",
                "UILaunchStoryboardName": "LaunchScreen",
            ]

            let (target, scheme) =
                Generator.frameworkDemoApp(name: name.framework.demoApp,
                                           destinations: destinations,
                                           deploymentTargets: deploymentTargets,
                                           infoPlist: infoPlist,
                                           dependencies: dependencies,
                                           bundleId: bundleId,
                                           unitTestName: unitTestsName,
                                           packageName: packageName)

            targets.append(target)
            schemes.append(scheme)
        }

        func makeUnitTests() {
            var dependencies = configure.framework.testing.dependency
            dependencies += hasTesting
                ? [.target(name: name.framework.testing)]
                : [.target(name: name.framework.module)]

            let target =
                Generator.frameworkUnitTests(name: name.framework.unitTests,
                                             destinations: destinations,
                                             deploymentTargets: deploymentTargets,
                                             dependencies: dependencies,
                                             packageName: packageName)
            targets.append(target)
        }

        makeModule(macho: macho)

        if hasTesting {
            makeTesting()
        }

        if hasDemoApp {
            makeDemoApp()
        }

        if hasUnitTests {
            makeUnitTests()
        }

        return (targets, schemes)
    }
}

// MARK: UI

private extension Project {
    static func makeUITargets(name: Name,
                              hasInternalDTO: Bool,
                              hasUIPreview: Bool,
                              destinations: Destinations,
                              deploymentTargets: DeploymentTargets,
                              packageName: String?,
                              uiDependencies: [TargetDependency],
                              previewDependencies: [TargetDependency]) -> ([Target], [Scheme]) {
        var targets: [Target] = []
        var schemes: [Scheme] = []

        func makeUIModule() {
            var dependencies = uiDependencies
            if hasInternalDTO {
                dependencies.append(.target(name: name.internalDTO))
            }

            let (target, scheme) =
                Generator.uiModule(name: name.ui.module,
                                   destinations: destinations,
                                   deploymentTargets: deploymentTargets,
                                   dependencies: dependencies,
                                   packageName: packageName)
            targets.append(target)
            schemes.append(scheme)
        }

        func makeUIPreview() {
            let dependencies = previewDependencies + [.target(name: name.ui.module)]

            let (target, scheme) =
                Generator.uiPreview(name: name.ui.preview,
                                    destinations: destinations,
                                    deploymentTargets: deploymentTargets,
                                    dependencies: dependencies,
                                    packageName: packageName)
            targets.append(target)
            schemes.append(scheme)
        }

        makeUIModule()

        if hasUIPreview {
            makeUIPreview()
        }

        return (targets, schemes)
    }
}

// MARK: InternalDTO

private extension Project {
    static func makeInternalDTOTarget(name: Name,
                                      destinations: Destinations,
                                      deploymentTargets: DeploymentTargets,
                                      packageName: String?) -> (Target, Scheme) {
        let (target, scheme) =
            Generator.internalDTOTarget(name: name.internalDTO,
                                        destinations: destinations,
                                        deploymentTargets: deploymentTargets,
                                        packageName: packageName)
        return (target, scheme)
    }
}
