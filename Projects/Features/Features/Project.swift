import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "Features",
               dependencies: [
                .Project.Domain.Main,
                .Project.Domain.Loan,
                .Project.Domain.Settings,
                .Project.DataRepository.Main,
                .Project.DataRepository.Loan,
                .Project.DataRepository.Settings,
               ])
