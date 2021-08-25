import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureMainDomain",
                     dependencies: [
                        .Project.Domain.DependencyComponent,
                        .Project.Feature.Main.UserInterface,
                     ])
