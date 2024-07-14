import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedFramework(
        name: "DesignSystem",
        packages: [
            .UserInterface.ResourcePackage,
            .FlexLayout,
            .PinLayout,
            .SnapKit,
        ],
        dependencies: [
            .SwiftPM.UserInterface.ResourcePackage,
            .SwiftPM.FlexLayout,
            .SwiftPM.PinLayout,
            .SwiftPM.SnapKit,
        ],
        hasDemoApp: true
    )
