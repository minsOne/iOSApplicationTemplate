import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureDomainComponent",
               		 dependencies: [
						.Project.Module.ThirdPartyLibraryManager,
						.Project.Module.RxPackage,
               		 ])
