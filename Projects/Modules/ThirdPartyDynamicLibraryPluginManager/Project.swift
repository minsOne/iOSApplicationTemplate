import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "ThirdPartyDynamicLibraryPluginManager",
                     dependencies: [
                        [.Project.ThirdPartyLibraryManager],
                        TargetDependency.Framework.Facebook,
                     ].flatMap { $0 })
