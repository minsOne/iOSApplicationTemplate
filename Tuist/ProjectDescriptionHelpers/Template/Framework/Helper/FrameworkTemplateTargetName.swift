import Foundation

struct FrameworkTemplateTargetName {
    let framework: Framework
    let ui: UI
    let internalDTO: String
    let project: String

    init(_ name: String) {
        framework = .init(
            module: name,
            testing: "\(name)Testing",
            demoApp: "\(name)DemoApp",
            unitTests: "\(name)UnitTests",
            widgetExtension: "\(name)WidgetExtension"
        )
        ui = .init(
            module: "\(name)UI",
            uiPreview: "\(name)UIPreview",
            uiPreviewApp: "\(name)UIPreviewApp"
        )
        internalDTO = "\(name)InternalDTO"
        project = name
    }
}

extension FrameworkTemplateTargetName {
    struct Framework {
        let module: String
        let testing: String
        let demoApp: String
        let unitTests: String
        let widgetExtension: String
    }

    struct UI {
        let module: String
        let uiPreview: String
        let uiPreviewApp: String
    }
}
