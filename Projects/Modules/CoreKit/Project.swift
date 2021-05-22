import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "CoreKit",
               dependencies: [
                .Project.networkAPI,
                .Project.utilityKit,
                .Project.resourceManager,
               ])
