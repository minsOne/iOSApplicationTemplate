import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "DesignSystem",
    target: [
        .framework([.module(.static)]),
    ],
    packages: [
        .UserInterface.ResourcePackage,
        .FlexLayout,
        .PinLayout,
        .SnapKit,
    ],
    configure: .init(
        framework: .init(dependency: [
            .SwiftPM.UserInterface.ResourcePackage,
            .SwiftPM.FlexLayout,
            .SwiftPM.PinLayout,
            .SwiftPM.SnapKit,
        ])
    )
).project
