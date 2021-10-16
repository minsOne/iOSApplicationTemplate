import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "Framework template",
    attributes: [nameAttribute, .optional("platform", default: "iOS")],
    files: [
        [
            .file(path: "\(nameAttribute)/Example/Sources/AppDelegate.swift",
                  templatePath: "contents_appdelegate.stencil"),
            .file(path: "\(nameAttribute)/Example/Resources/Assets.xcassets/contents.json",
                  templatePath: "contents_xcassets.stencil"),
            .file(path: "\(nameAttribute)/Example/Resources/Assets.xcassets/AppIcon.appiconset/contents.json",
                  templatePath: "contents_xcassetsAppIcon.stencil"),
            .file(path: "\(nameAttribute)/Example/Resources/LaunchScreen.storyboard",
                  templatePath: "LaunchScreen.stencil"),
        ],
        [
            .file(path: "\(nameAttribute)/Sources/\(nameAttribute).swift",
                  templatePath: "contents_example.stencil"),
            .string(path: "\(nameAttribute)/Resources/dummy.txt",
                    contents: "_"),
        ],
        [
            .file(path: "\(nameAttribute)/Tests/Sources/\(nameAttribute)Tests.swift",
                  templatePath: "contents_tests_xctest.stencil"),
            .file(path: "\(nameAttribute)/Tests/Sources/\(nameAttribute)TestSpec.swift",
                  templatePath: "contents_tests_quick_nimble.stencil"),
            .string(path: "\(nameAttribute)/Tests/Resources/dummy.txt",
                    contents: "_"),
        ],
        [
            .file(path: "\(nameAttribute)/Testing/Sources/\(nameAttribute).swift",
                  templatePath: "contents_testing.stencil"),
            .string(path: "\(nameAttribute)/Testing/Resources/dummy.txt",
                    contents: "_"),
        ],
        [
            .file(path: "\(nameAttribute)/Project.swift",
                  templatePath: "contents_project.stencil"),
        ]
    ].flatMap { $0 }
)
