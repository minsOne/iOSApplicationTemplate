import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project
    .staticFramework(name: "NetworkAPIKit",
                     packages: [
                        .alamofire
                     ],
                     dependencies: [
                        .SwiftPM.alamofire
                     ])
