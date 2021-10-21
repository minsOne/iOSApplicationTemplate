import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOExampleDevToolPackage",
    targets: Set([
       .dynamicFramework,
       .tests,
       .example,
       .testing
    ]),
    dependencies: [
        .Framework.DevelopTool.FLEX,
        .Framework.DevelopTool.TouchVisualizer,
    ]
)
