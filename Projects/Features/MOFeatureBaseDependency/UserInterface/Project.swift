import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOFeatureBaseDependencyUserInterface",
    targets: Set([
       .staticLibrary,
       .tests,
       .example,
       .testing
    ]),
    dependencies: [
        Dep.Project.UserInterface.DesignSystem.DesignSystemKit,
    ]
)
