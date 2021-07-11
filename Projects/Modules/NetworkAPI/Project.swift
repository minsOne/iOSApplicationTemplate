import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "NetworkAPI",
                     dependencies: [
                        .Project.Network.Common,
                        .Project.Network.Home,
                        .Project.Network.Login,
                     ])
