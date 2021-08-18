import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "InjectionManager",
               		 dependencies: [
						.Project.Module.CoreKit,
						.Project.Feature.Features,
               		 ])
