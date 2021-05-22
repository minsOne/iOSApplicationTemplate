import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project
    .staticLibrary(name: "NetworkAPIKit",
                   dependencies: [
                    .Project.swiftPackageMerge
                   ])
