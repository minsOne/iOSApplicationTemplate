import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "NetworkAPICommon",
               		 dependencies: [
                        .Project.Module.NetworkAPIKit
               		 ])
