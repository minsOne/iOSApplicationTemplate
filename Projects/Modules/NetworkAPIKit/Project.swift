import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project
    .staticFramework(name: "NetworkAPIKit",
                     dependencies: [
                        .Project.ThirdPartyLibraryManager
                     ])
