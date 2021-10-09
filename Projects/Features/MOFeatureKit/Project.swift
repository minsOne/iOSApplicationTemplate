import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOFeatureKit",
    targets: Set([
       .dynamicframework,
       .tests,
       .example,
       .testing
    ]),
    dependencies: [
        Dep.Project.Module.Core.CoreKit,
        Dep.Project.UserInterface.DesignSystem.DesignSystemKit,
    ]
)
