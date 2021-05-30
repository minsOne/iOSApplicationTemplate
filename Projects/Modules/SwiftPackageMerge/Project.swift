import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project
    .framework(name: "SwiftPackageMerge",
               packages: [
                .Alamofire
               ],
               dependencies: [
                .SwiftPM.Alamofire
               ])
