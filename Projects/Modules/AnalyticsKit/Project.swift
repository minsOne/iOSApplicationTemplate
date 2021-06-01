import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project
    .framework(name: "AnalyticsKit",
               dependencies: TargetDependency.Framework.Firebase)
