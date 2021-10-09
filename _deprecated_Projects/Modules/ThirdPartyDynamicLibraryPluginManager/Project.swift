import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "ThirdPartyDynamicLibraryPluginManager",
                     dependencies: [
                        [.Project.Module.ThirdPartyLibraryManager],
                        TargetDependency.Framework.Facebook,
                     ].flatMap { $0 })
