import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureUserInterfaceComponent",
               		 dependencies: [
						.Project.UserInterface.DesignSystem,
						.Project.Module.RxPackage,
               		 ])
