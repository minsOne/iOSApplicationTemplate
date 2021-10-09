import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "RepositoryInjectManager",
               		 dependencies: [
						.Project.Module.CoreKit,
						.Project.Feature.Features,
               		 ])
