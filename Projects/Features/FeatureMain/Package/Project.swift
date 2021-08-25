import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureMainPackage",
                     dependencies: [
                        .Project.Feature.Main.DataRepository,
                        .Project.Feature.Main.Domain,
                        .Project.Feature.Main.UserInterface,
                     ])
