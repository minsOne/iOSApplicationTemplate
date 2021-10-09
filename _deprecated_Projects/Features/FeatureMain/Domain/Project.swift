import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureMainDomain",
                     dependencies: [
                        .Project.Feature.BaseDependency.Domain,
                        .Project.Feature.Main.UserInterface,
                     ])
