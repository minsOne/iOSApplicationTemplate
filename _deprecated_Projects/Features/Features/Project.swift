import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project
    .framework(name: "Features",
               dependencies: [
                Dep.Project.Feature.Loan.Pacakge,
                Dep.Project.Feature.Main.Pacakge,
                Dep.Project.Feature.Settings.Pacakge,
               ].flatMap { $0 })
