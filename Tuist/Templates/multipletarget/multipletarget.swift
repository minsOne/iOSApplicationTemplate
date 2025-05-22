import ProjectDescription

let multipleTargetTemplateNameAttribute = Template.Attribute .required("name")

let multipleTargetTemplate = Template(
    description: "Multiple Target template",
    attributes: [
        nameAttribute,
    ],
    items: [
        // MARK: - Framework
        .string(
            path: "\(nameAttribute)/Sources/Target1/File.swift",
            contents: ""
        ),

        // MARK: - UnitTests
        .file(
            path: "\(nameAttribute)/Tests/\(nameAttribute)Tests.swift",
            templatePath: "Stencil/Framework/unitTests.stencil"
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
