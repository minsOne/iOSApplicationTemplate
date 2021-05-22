import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(name: "App",
                          projects: [
                            "Projects/App",
                          ],
                          schemes: [
                            .Workspace.makeAppScheme(target: .test),
                            .Workspace.makeModuleScheme(name: "CoreKit", target: .test),
                          ])
