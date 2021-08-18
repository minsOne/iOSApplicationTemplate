import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureLoanDomain",
               		 dependencies: [
						.Project.Domain.DependencyComponent,
						.Project.UserInterface.Loan,
               		 ])
