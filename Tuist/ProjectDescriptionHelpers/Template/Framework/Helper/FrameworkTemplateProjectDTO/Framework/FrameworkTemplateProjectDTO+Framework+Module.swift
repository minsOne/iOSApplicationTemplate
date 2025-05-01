import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator
private typealias TemplateDTO = FrameworkTemplateProjectDTO

extension TemplateDTO.Framework {
    struct Module {
        struct Info {
            let name: FrameworkTemplateTargetName
            let macho: FrameworkTemplate.Target.Framework.MachO
            let hasInterface: Bool
            let hasUnitTests: Bool
            let hasInternalDTO: Bool
            let hasUI: Bool
            let destinations: Destinations
            let deploymentTargets: DeploymentTargets
            let configure: FrameworkTemplate.TargetConfigure
            let dependencies: [TargetDependency]
            let needResources: Bool
        }

        let target: Target
        let scheme: Scheme

        init(info: Info) {
            let macho: Generator.Framework.MachO = switch info.macho {
            case .dynamic: .dynamic
            case .static: .static
            }
            let isHiddenScheme = info.configure.framework.isHiddenScheme
            let unitTestsName = info.hasUnitTests ? info.name.framework.unitTests : nil
            let needResources = info.needResources

            var dependencies = info.dependencies
            if info.hasInterface {
                dependencies.append(.target(name: info.name.interface))
            }
            if info.hasUI {
                dependencies.append(.target(name: info.name.ui.module))
            }
            if info.hasInternalDTO {
                dependencies.append(.target(name: info.name.internalDTO))
            }

            let module = Generator.Framework.Module(
                name: info.name.framework.module,
                macho: macho,
                destinations: info.destinations,
                deploymentTargets: info.deploymentTargets,
                dependencies: dependencies,
                hiddenScheme: isHiddenScheme,
                unitTestsName: unitTestsName, 
                needResources: needResources
            )
            scheme = module.scheme
            target = module.target
        }
    }
}
