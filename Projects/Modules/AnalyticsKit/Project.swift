import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "AnalyticsKit",
    target: [
        .framework([.module(.static)]),
    ],
    configure: .init(
        framework: .init(dependency: [
            .Project.Module.ThirdPartyLibraryManager,
        ])
    )
).project
