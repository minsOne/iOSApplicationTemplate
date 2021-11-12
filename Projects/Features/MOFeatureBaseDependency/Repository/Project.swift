import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOFeatureBaseDependencyRepository",
    targets: Set([
       .staticLibrary,
       .tests,
       .example,
       .testing
    ]),
    dependencies: []
)
