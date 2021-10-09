import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "DesignSystem",
               packages: [
                .UserInterface.ResourcePackage,
               ],
               dependencies: [
                .SwiftPM.UserInterface.ResourcePackage,
                .Framework.FlexLayout,
                .Framework.PinLayout,
                .Framework.SnapKit,
               ],
               hasDemoApp: true)
