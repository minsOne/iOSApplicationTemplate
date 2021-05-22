//
//  WorkspaceScheme.swift
//  ProjectDescriptionHelpers
//
//  Created by minsone on 2021/05/23.
//

import ProjectDescription
import UtilityPlugin

public extension Scheme {
    struct Workspace {}
}
public extension Scheme.Workspace {
    static func makeAppScheme(target: ProjectDeployTarget) -> Scheme {
        return Scheme(name: "Workspace-App-\(target.rawValue)",
                      shared: true,
                      buildAction: BuildAction(targets: [.project(path: .app, target: "App")], preActions: []),
                      testAction: TestAction(targets: [TestableTarget(target: .project(path: .app, target: "AppTests"))],
                                             configurationName: target.rawValue,
                                             coverage: true),
                      runAction: RunAction(configurationName: target.rawValue),
                      archiveAction: ArchiveAction(configurationName: target.rawValue),
                      profileAction: ProfileAction(configurationName: target.rawValue),
                      analyzeAction: AnalyzeAction(configurationName: target.rawValue))
    }
    
    static func makeModuleScheme(name: String, target: ProjectDeployTarget) -> Scheme {
        let schemeName = "Workspace-\(name)-\(target.rawValue)"
        return Scheme(name: schemeName,
                      shared: true,
                      buildAction: BuildAction(targets: [.project(path: .relativeToModule(name), target: name)], preActions: []),
                      testAction: TestAction(targets: [TestableTarget(target: .project(path: .relativeToModule(name),
                                                                                       target: "\(name)Tests"))],
                                             configurationName: target.rawValue,
                                             coverage: true),
                      runAction: RunAction(configurationName: target.rawValue),
                      archiveAction: ArchiveAction(configurationName: target.rawValue),
                      profileAction: ProfileAction(configurationName: target.rawValue),
                      analyzeAction: AnalyzeAction(configurationName: target.rawValue))
    }
}
