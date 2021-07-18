import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "DesignSystem",
               		 dependencies: [
                        .Project.CoreKit
               		 ],
               		 hasDemoApp: true)
