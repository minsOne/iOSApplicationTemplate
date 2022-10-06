import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOCoreKit",
    targets: Set([
       .staticLibrary,
       .tests,
       .example,
       .testing
    ]),
    dependencies: [
        Dep.Project.Module.Core.AppLogger,
        Dep.Project.Module.Core.Network.NetworkAPIs,
    ]
)
