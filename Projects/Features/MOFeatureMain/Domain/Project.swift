import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOFeatureMainDomain",
    targets: Set([
        .staticLibrary,
        .tests,
        .example,
        .testing
    ]),
    dependencies: [
        Dep.Project.Feature.BaseDependency.Domain,
        Dep.Project.Feature.Main.UserInterface,
    ]
)
