import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(name: "App",
                          projects: [
                            "Projects/DesignSystem/MODesignSystemKit",
                            "Projects/Features/MOFeatureKit",
                            "Projects/Modules/Core/MOCoreKit",
                            "Projects/Modules/RxPackage"
                          ])
