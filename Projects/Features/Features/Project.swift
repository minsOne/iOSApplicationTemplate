import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "Features",
               dependencies: [
                Dep.Project.Feature.Loan.Pacakge,
                Dep.Project.Feature.Main.Pacakge,
                Dep.Project.Feature.Settings.Pacakge,
               ].flatMap { $0 })
