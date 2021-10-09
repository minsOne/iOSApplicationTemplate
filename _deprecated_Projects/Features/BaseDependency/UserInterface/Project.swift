import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureBaseDependencyUserInterface",
               		 dependencies: [
						.Project.UserInterface.DesignSystem,
						.Project.Module.RxPackage,
               		 ],
					 hasDemoApp: true)
