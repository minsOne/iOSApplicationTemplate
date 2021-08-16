import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "Features",
               dependencies: [
                .Project.Feature.Main,
               ])
