import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeaturesComponent",
                     dependencies: [
                        .Project.Module.CoreKit
                     ])
