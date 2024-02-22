import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(
        name: "NetworkAPICommon",
        dependencies: [
            .Project.Network.APIKit,
        ]
    )
