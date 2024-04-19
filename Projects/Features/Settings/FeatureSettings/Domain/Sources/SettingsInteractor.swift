//
//  SettingsInteractor.swift
//  FeatureSettingsDomain
//
//  Created by minsone on 2021/08/18.
//  Copyright © 2021 minsone. All rights reserved.
//

import RIBs
import RxSwift
import ReactorKit

public protocol SettingsRouting: ViewableRouting {
    func routeToApplyCard()
}

public protocol SettingsPresentable: Presentable {
    var listener: SettingsPresentableListener? { get set }
}

public protocol SettingsListener: AnyObject {
    func finish()
    func moveToMain()
}

public enum SettingsAction {
    case viewDidLoad
    case applyCheckCard
    case finish
    case moveToMain
}

public struct SettingsState {
    var text: String
    var 계좌종류: String

    init(text: String,
         계좌종류: String) {
        self.text = text
        self.계좌종류 = 계좌종류
    }
}

final class SettingsInteractor:
    PresentableInteractor<SettingsPresentable>,
    SettingsInteractable,
    SettingsPresentableListener,
    Reactor {

    enum Mutation {
        case viewDidLoad
        case 체크카드신청할까말까
        case 메인으로갈까말까
    }

    typealias Action = SettingsAction
    typealias State = SettingsState

    var initialState: SettingsState = .init(text: "Hello",
                                            계좌종류: "입출금(한도계좌)")

    weak var router: SettingsRouting?
    weak var listener: SettingsListener?
    
    private let useCase: SettingsUseCase

    init(presenter: SettingsPresentable,
         useCase: SettingsUseCase) {
        self.useCase = useCase

        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        useCase.requestSettings()
            .subscribe(onSuccess: { model in
                print(model)
            })
            .disposeOnDeactivate(interactor: self)
    }

    override func willResignActive() {
        super.willResignActive()
    }


    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .just(.viewDidLoad)
        case .applyCheckCard:
            return .just(.체크카드신청할까말까)
        case .finish:
            listener?.finish()
            return .empty()
        case .moveToMain:
            return .just(.메인으로갈까말까)
        }
    }

    func reduce(state: SettingsState, mutation: Mutation) -> SettingsState {
        var newState = state

        switch mutation {
        case .viewDidLoad:
            newState.text = "Hello World"
        case .체크카드신청할까말까:
            newState.text = "체크카드 신청하러 갈까 말까"
            newState.계좌종류 = "입출금(미니계좌)"
        case .메인으로갈까말까:
            newState.text = "메인화면으로 갈까 말까"
            newState.계좌종류 = "입출금(일반계좌)"
        }

        return newState
    }
}
