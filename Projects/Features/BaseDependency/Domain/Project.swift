import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(name: "FeatureBaseDependencyDomain",
               		 dependencies: [
						.Project.Module.ThirdPartyLibraryManager,
               		 ])
