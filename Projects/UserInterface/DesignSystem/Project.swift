import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "DesignSystem",
               packages: [
                .UserInterface.ProxyResourcePackage,
               ],
               dependencies: [
                .SwiftPM.UserInterface.ProxyResourcePackage,
                .Framework.FlexLayout,
                .Framework.PinLayout,
                .Framework.SnapKit,
               ],
               hasDemoApp: true)
