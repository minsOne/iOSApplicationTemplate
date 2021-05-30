import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project
    .framework(name: "DevelopTool",
               packages: [
                .OHHTTPStubs
               ],
               dependencies: [
                .SwiftPM.OHHTTPStubs
               ])
