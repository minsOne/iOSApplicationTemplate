import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureBaseDependencyDomain",
               		 dependencies: [
						.Project.Module.ThirdPartyLibraryManager,
						.Project.Module.RxPackage,
               		 ])
