import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "MOFoundationKit",
    target: [
        .framework([.module(.static)]),
    ],
    configure: .init(
        framework: .init(dependency: [
            .Project.Module.Foundation.Container,
        ]))
).project
