import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "NetworkAPIs",
    target: [
        .framework([.module(.static)]),
    ],
    configure: .init(
        framework: .init(dependency: [
            .Project.Network.Common,
            .Project.Network.Home,
            .Project.Network.Login,
        ])
    )
).project
