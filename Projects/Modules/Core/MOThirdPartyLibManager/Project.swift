import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOThirdPartyLibManager",
    targets: Set([
       .dynamicframework,
       .tests,
       .example,
       .testing
    ]),
    dependencies: []
)
