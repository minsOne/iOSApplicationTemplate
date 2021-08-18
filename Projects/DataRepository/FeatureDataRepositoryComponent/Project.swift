import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureDataRepositoryComponent",
               		 dependencies: [
						.Project.Module.CoreKit,
						.Project.Module.RxPackage,
               		 ])
