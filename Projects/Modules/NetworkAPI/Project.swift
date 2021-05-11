import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "NetworkAPI",
                     dependencies: [
                        .networkAPIKit
                     ])
