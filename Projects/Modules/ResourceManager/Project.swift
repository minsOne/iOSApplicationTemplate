import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticLibrary(name: "ResourceManager",
                   packages: [
                    .ResourcePackage
                   ],
                   dependencies: [
                    .SwiftPM.ResourcePackage
                   ])
