import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureSharedComponent",
                     dependencies: [
                        .Project.CoreKit
                     ])
