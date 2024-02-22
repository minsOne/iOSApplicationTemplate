import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(
        name: "ThirdPartyDynamicLibraryPluginManager",
        dependencies: [
            [.Project.Module.ThirdPartyLibraryManager],
            TargetDependency.Framework.Facebook,
        ].flatMap { $0 }
    )
