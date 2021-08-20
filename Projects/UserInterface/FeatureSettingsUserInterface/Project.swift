import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureSettingsUserInterface",
               		 dependencies: [
						.Project.UserInterface.DependencyComponent,
						.Project.UserInterface.DesignSystem,
               		 ],
					 hasDemoApp: true)
