import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(
        name: "NetworkAPIHome",
        dependencies: [
            .Project.Network.APIKit,
        ]
    )
