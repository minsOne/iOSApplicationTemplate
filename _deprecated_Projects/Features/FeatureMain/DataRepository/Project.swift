import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureMainDataRepository",
                     dependencies: [
                        .Project.Feature.BaseDependency.DataRepository,
                        .Project.Feature.Main.Domain,
                     ])
