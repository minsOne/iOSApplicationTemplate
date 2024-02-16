import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

let template = Template(
    description: "Framework template",
    attributes: [
        nameAttribute,
    ],
    items: [
        // Framework
        .string(path: "\(nameAttribute)/Sources/Framework/Module/File.swift", contents: ""),
        // Testing
        .string(path: "\(nameAttribute)/Sources/Framework/Testing/File.swift", contents: ""),
        // DemoApp
        .string(path: "\(nameAttribute)/App/DemoApp/File.swift", contents: ""),
        // UnitTests
        .file(path: "\(nameAttribute)/Tests/UnitTests/\(nameAttribute)Tests.swift", templatePath: "stencil/unitTests.stencil"),
        // UI
        .string(path: "\(nameAttribute)/Sources/UI/Module/File.swift", contents: ""),
        // UIPreview
        .string(path: "\(nameAttribute)/Sources/UI/UIPreview/File.swift", contents: ""),
        // InternalDTO
        .string(path: "\(nameAttribute)/Sources/InternalDTO/File.swift", contents: ""),
        // Project
        .file(path: "\(nameAttribute)/Project.swift", templatePath: "project.stencil"),
    ]
)
