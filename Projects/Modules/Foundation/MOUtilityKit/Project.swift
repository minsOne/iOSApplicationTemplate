import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOUtilityKit",
    targets: Set([
       .staticframework,
       .tests,
       .example,
       .testing
    ]),
    dependencies: []
)
