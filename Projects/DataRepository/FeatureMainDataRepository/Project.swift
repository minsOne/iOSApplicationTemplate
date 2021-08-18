import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureMainDataRepository",
               		 dependencies: [
						.Project.DataRepository.DependencyComponent,
						.Project.Domain.Main,
               		 ])
