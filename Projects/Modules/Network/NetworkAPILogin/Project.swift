import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "NetworkAPILogin",
                     dependencies: [
                        .Project.Network.APIKit
                     ])
