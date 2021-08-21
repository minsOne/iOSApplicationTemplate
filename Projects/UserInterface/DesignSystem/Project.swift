import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "DesignSystem",
               packages: [
                .UserInterface.ProxyResourcePackage,
                .UserInterface.Blueprint,
                .UserInterface.PinLayout,
                .UserInterface.SnapKit,
               ],
               dependencies: [
                .SwiftPM.UserInterface.ProxyResourcePackage,
                .SwiftPM.UserInterface.BlueprintUI,
                .SwiftPM.UserInterface.BlueprintUICommonControls,
                .SwiftPM.UserInterface.PinLayout,
                .SwiftPM.UserInterface.SnapKit,
                .Framework.FlexLayout,
               ],
               hasDemoApp: true)
