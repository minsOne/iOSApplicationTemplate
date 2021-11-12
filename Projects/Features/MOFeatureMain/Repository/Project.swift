import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOFeatureMainRepository",
    targets: Set([
        .staticLibrary,
        .tests,
        .example,
        .testing
    ]),
    dependencies: [
        Dep.Project.Feature.BaseDependency.Repository,
        Dep.Project.Feature.Main.Domain,
    ]
)
