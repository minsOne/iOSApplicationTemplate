import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOExampleDevToolPackage",
    targets: Set([
       .staticframework,
       .tests,
       .example,
       .testing
    ]),
    dependencies: [
        .Framework.DevelopTool.FLEX,
        .Framework.DevelopTool.TouchVisualizer,
    ]
)
