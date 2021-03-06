import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MODesignSystemKit",
    targets: Set([
       .dynamicFramework,
       .tests,
       .example,
       .testing
    ]),
    packages: [
        .UserInterface.ResourcePackage
    ],
    dependencies: [
        Dep.SwiftPM.UserInterface.ResourcePackage,
    ]
)
