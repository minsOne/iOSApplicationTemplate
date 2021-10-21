import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOCoreKit",
    targets: Set([
       .dynamicFramework,
       .tests,
       .example,
       .testing
    ]),
    dependencies: [
        Dep.Project.Module.Core.AppLogger,
        Dep.Project.Module.Core.ThirdPartyLibManager,
        Dep.Project.Module.Core.Network.NetworkAPIs,
        Dep.Project.Module.Foundation.FoundationKit,
    ]
)
