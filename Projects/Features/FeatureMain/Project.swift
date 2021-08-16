import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureMain",
                     dependencies: [
                        .Project.Feature.MainComponent,
                     ])
