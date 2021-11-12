import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOFeatureKit",
    targets: Set([
        .dynamicFramework,
        .tests,
        .example,
        .testing
    ]),
    dependencies: [
        .Project.Feature.Main.Repository,
        .Project.Feature.Setting.Repository,
        .Project.Feature.Loan.Repository,
    ]
)
