import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "DesignSystem",
                     packages: [
                        .UserInterface.ProxyResourcePackage,
                        .UserInterface.Blueprint,
                        .UserInterface.FlexLayout,
                        .UserInterface.SnapKit,
                     ],
                     dependencies: [
                        .SwiftPM.UserInterface.ProxyResourcePackage,
                        .SwiftPM.UserInterface.BlueprintUI,
                        .SwiftPM.UserInterface.BlueprintUICommonControls,
                        .SwiftPM.UserInterface.FlexLayout,
                        .SwiftPM.UserInterface.SnapKit,
                     ],
                     hasDemoApp: true)
