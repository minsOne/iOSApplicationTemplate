import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticLibrary(name: "ResourceManager",
                   packages: [
                    .resourcePackage
                   ],
                   dependencies: [
                    .SwiftPM.resourcePackage
                   ])
