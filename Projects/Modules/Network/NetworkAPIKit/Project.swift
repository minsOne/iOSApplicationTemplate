import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "NetworkAPIKit",
                     dependencies: [
                        .Project.Module.ThirdPartyLibraryManager
                     ])
