import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "NetworkAPIKit",
                     packages: [
                        .alamofire
                     ],
                     dependencies: [
                        .alamofire
                     ])
