import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(name: "NetworkAPILogin",
                     dependencies: [
                        .Project.Network.APIKit
                     ])
