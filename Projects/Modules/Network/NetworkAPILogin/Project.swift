import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "NetworkAPILogin",
    target: [
        .framework([.module(.static)]),
    ],
    configure: .init(
        framework: .init(dependency: [
            .Project.Network.APIKit,
        ])
    )
).project
