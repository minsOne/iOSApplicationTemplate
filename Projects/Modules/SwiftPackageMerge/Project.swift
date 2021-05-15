import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project
    .framework(name: "SwiftPackageMerge",
               packages: [
                .alamofire
               ],
               dependencies: [
                .SwiftPM.alamofire
               ])
