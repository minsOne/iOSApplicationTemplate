import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(name: "Application",
                          projects: [
                            "Projects/DesignSystem/MODesignSystemKit",
                            "Projects/Features/MOFeatureKit",
                            "Projects/Modules/Core/MOCoreKit",
                            "Projects/Modules/Core/MORxPackageExtension",
                          ])
