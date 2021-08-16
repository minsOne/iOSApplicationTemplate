import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "UserInterfaceLibraryManager",
               		 dependencies: [
						.Project.UserInterface.DesignSystem,
						.Project.Module.RxPackage,
               		 ])
