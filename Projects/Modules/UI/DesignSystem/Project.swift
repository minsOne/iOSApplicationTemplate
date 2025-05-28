import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "DesignSystem",
    packages: [
        .UserInterface.ResourcePackage,
        .FlexLayout,
        .PinLayout,
        .SnapKit,
    ],
    target: [
        .framework([.module(.static)]),
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
