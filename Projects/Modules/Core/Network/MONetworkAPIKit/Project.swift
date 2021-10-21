import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MONetworkAPIKit",
    targets: Set([
       .staticLibrary,
       .tests,
       .example,
       .testing
    ]),
    dependencies: [
        Dep.Project.Module.Core.ThirdPartyLibManager,
        Dep.Project.Module.Foundation.FoundationKit,
    ]
)
