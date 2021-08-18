import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureLoanDataRepository",
               		 dependencies: [
						.Project.DataRepository.DependencyComponent,
						.Project.Domain.Loan,
               		 ])
