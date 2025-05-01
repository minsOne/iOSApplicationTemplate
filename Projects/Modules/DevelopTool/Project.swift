import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "DevelopTool",
    target: [
        .framework([.module(.static)]),
    ],
    packages: [
        .DevelopTool.OHHTTPStubs,
        .DevelopTool.ProxyNetworkStubPackage,
        .DevelopTool.FLEX,
    ],
    configure: .init(
        framework: .init(dependency: [
            .SwiftPM.DevelopTool.OHHTTPStubs,
            .SwiftPM.DevelopTool.OHHTTPStubsSwift,
            .SwiftPM.DevelopTool.ProxyNetworkStubPackage,
            .SwiftPM.DevelopTool.FLEX,
        ])
    )
).project
