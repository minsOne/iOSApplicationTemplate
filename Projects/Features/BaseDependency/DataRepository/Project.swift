import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureBaseDependencyDataRepository",
               		 dependencies: [
						.Project.Module.CoreKit,
						.Project.Module.RxPackage,
               		 ])
