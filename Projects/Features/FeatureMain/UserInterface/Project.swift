import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureMainUserInterface",
               		 dependencies: [
						.Project.UserInterface.DependencyComponent,
						.Project.UserInterface.DesignSystem,
               		 ],
					 hasDemoApp: true)
