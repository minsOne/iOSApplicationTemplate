import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "NetworkAPIHome",
               		 dependencies: [
                        .Project.NetworkAPIKit
               		 ])
