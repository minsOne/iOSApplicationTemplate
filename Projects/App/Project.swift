import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project
    .app(name: "App",
         platform: .iOS,
         dependencies: [
            .Project.coreKit,
         ])
