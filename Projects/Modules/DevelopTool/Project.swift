import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project
    .framework(name: "DevelopTool",
               packages: [
                .DevelopTool.OHHTTPStubs,
                .DevelopTool.NetworkStub,
               ],
               dependencies: [
                .SwiftPM.DevelopTool.OHHTTPStubs,
                .SwiftPM.DevelopTool.OHHTTPStubsSwift,
                .SwiftPM.DevelopTool.NetworkStub,
                .Carthage.FLEX,
               ])
