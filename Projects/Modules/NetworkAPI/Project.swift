import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticLibrary(name: "NetworkAPI",
                   dependencies: [
                    .Project.networkAPIKit
                   ])
