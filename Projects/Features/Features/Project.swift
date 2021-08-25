import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "Features",
               dependencies: [
                .Project.Feature.Loan.Pacakge,
                .Project.Feature.Main.Pacakge,
                .Project.Feature.Settings.Pacakge,
               ])
