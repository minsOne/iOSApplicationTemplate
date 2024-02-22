import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedFramework(
        name: "DevelopTool",
        packages: [
            .DevelopTool.OHHTTPStubs,
            .DevelopTool.ProxyNetworkStubPackage,
        ],
        dependencies: [
            .SwiftPM.DevelopTool.OHHTTPStubs,
            .SwiftPM.DevelopTool.OHHTTPStubsSwift,
            .SwiftPM.DevelopTool.ProxyNetworkStubPackage,
            .Carthage.FLEX,
        ]
    )
