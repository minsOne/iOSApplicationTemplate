import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "ThirdPartyDynamicLibraryPluginManager",
    target: [
        .framework([.module(.static)]),
    ],
    configure: .init(
        framework: .init(dependency: [
            .Project.Module.ThirdPartyLibraryManager
        ] + TargetDependency.Framework.Facebook
        )
    )
).project
