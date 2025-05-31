import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "DevelopTool",
    packages: [
        .DevelopTool.OHHTTPStubs,
        .DevelopTool.ProxyNetworkStubPackage,
        .DevelopTool.FLEX,
    ],
    target: [
        .framework([.module(.static)]),
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
