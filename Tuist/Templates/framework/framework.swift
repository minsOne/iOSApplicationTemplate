import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "Framework template",
    attributes: [
        nameAttribute,
    ],
    items: [
        // MARK: - Framework
        .string(
            path: "\(nameAttribute)/Sources/Framework/File.swift",
            contents: ""
        ),

        // MARK: - Testing
        .string(
            path: "\(nameAttribute)/Testing/File.swift",
            contents: ""
        ),

        // MARK: - DemoApp
        .file(
            path: "\(nameAttribute)/App/DemoApp/Sources/AppDelegate.swift",
            templatePath: "Stencil/Framework/DemoApp/AppDelegate.stencil"
        ),
        .file(
            path: "\(nameAttribute)/App/DemoApp/Resources/LaunchScreen.storyboard",
            templatePath: "Stencil/Framework/DemoApp/LaunchScreen.stencil"
        ),
        .directory(
            path: "\(nameAttribute)/App/DemoApp/Resources/Assets.xcassets",
            sourcePath: "Stencil/Framework/DemoApp/Assets.xcassets"
        ),

        // MARK: - UnitTests
        .file(
            path: "\(nameAttribute)/Tests/UnitTests/\(nameAttribute)Tests.swift",
            templatePath: "Stencil/Framework/unitTests.stencil"
        ),

        // MARK: - UI
        .string(
            path: "\(nameAttribute)/Sources/UI/File.swift",
            contents: ""
        ),

        // MARK: - UIPreview
        .string(
            path: "\(nameAttribute)/UIPreview/File.swift",
            contents: ""
        ),

        // MARK: - InternalDTO
        .string(
            path: "\(nameAttribute)/Sources/InternalDTO/File.swift",
            contents: ""
        ),

        // MARK: - Project
        .file(
            path: "\(nameAttribute)/Project.swift",
            templatePath: "Stencil/Project/project.stencil"
        ),
        .file(
            path: "\(nameAttribute)/README.md",
            templatePath: "Stencil/Project/README.stencil"
        ),
    ]
)
