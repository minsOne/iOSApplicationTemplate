import Foundation
import ProjectDescription

private typealias Generator = FrameworkTemplateTargetSchemeGenerator

extension Generator {
    struct Project {
        let project: ProjectDescription.Project

        init(name: String,
             packages: [Package] = [],
             targets: [Target],
             schemes: [Scheme],
             packageName: String?)
        {
            var baseSettings: SettingsDictionary = [
                "CODE_SIGN_IDENTITY": "",
                "CODE_SIGNING_REQUIRED": "NO",
            ]
            if let packageName {
                baseSettings.updateValue("\(packageName)",
                                         forKey: "SWIFT_PACKAGE_NAME")
            }

            project = .init(
                name: name,
                organizationName: FrameworkTemplate.DefaultValue.organizationName,
                options: .options(
                    automaticSchemesOptions: .disabled,
                    disableBundleAccessors: true,
                    disableShowEnvironmentVarsInScriptPhases: true,
                    disableSynthesizedResourceAccessors: true
                ),
                packages: packages,
                settings: .settings(
                    base: baseSettings,
                    configurations: [
                        .debug(name: .dev, xcconfig: .moduleXCConfig(type: .dev)),
                        .debug(name: .test, xcconfig: .moduleXCConfig(type: .test)),
                        .release(name: .qa, xcconfig: .moduleXCConfig(type: .qa)),
                        .release(name: .stage, xcconfig: .moduleXCConfig(type: .stage)),
                        .release(name: .prod, xcconfig: .moduleXCConfig(type: .prod)),
                    ]
                ),
                targets: targets,
                schemes: schemes,
                fileHeaderTemplate: nil,
                additionalFiles: [
                    .glob(pattern: "README.md"),
                    .glob(pattern: "Project.swift"),
                ]
            )
        }
    }
}
