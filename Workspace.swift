import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(name: "App",
                          projects: [
                            "Projects/Modules/Core/MOCoreKit",
                            "Projects/DesignSystem/MODesignSystemKit",
                            "Projects/Features/MOFeatureKit",
                          ])
