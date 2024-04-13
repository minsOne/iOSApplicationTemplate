struct FrameworkTemplateTargetName {
    struct Framework {
        let module: String
        let testing: String
        let demoApp: String
        let unitTests: String
    }

    struct UI {
        let module: String
        let preview: String
    }

    let framework: Framework
    let ui: UI
    let internalDTO: String
    let project: String

    init(_ name: String) {
        framework = .init(
            module: name,
            testing: "\(name)Testing",
            demoApp: "\(name)DemoApp",
            unitTests: "\(name)UnitTests"
        )
        ui = .init(
            module: "\(name)UI",
            preview: "\(name)UIPreview"
        )
        internalDTO = "\(name)InternalDTO"
        project = name
    }
}
