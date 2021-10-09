//
//  RootRouter.swift
//  App
//
//  Created by minsone on 2021/06/20.
//  Copyright © 2021 minsone. All rights reserved.
//

import RIBs
import FeatureSettingsDomain

protocol RootInteractable:
    Interactable,
    FeatureSettingsDomain.SettingsListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    private let settingsBuilder: FeatureSettingsDomain.SettingsBuildable
    private var settingsRouter: ViewableRouting?

    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         settingsBuilder: FeatureSettingsDomain.SettingsBuildable) {
        self.settingsBuilder = settingsBuilder
        
        super.init(interactor: interactor,
                   viewController: viewController)
        interactor.router = self
    }
    
    func routeToSettings() {
        guard settingsRouter == nil else { return }

        let router = settingsBuilder.build(withListener: interactor)
        settingsRouter = router
        attachChild(router)
        let vc = router.viewControllable.uiviewController
        vc.modalPresentationStyle = .fullScreen

        viewController.uiviewController
            .present(vc, animated: true, completion: nil)
    }

    func detachSettings() {
        guard let router = settingsRouter else { return }
        router.viewControllable
            .uiviewController
            .dismiss(animated: true, completion: { [weak self] in
                self?.settingsRouter = nil
                self?.detachChild(router)
        })
    }
}
