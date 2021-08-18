//___FILEHEADER___

import RIBs
import RxSwift

protocol ___VARIABLE_productName___Routing: Routing {
    func cleanupViews()
}

protocol ___VARIABLE_productName___Listener: AnyObject {}

final class ___VARIABLE_productName___Interactor: Interactor, ___VARIABLE_productName___Interactable {

    weak var router: ___VARIABLE_productName___Routing?
    weak var listener: ___VARIABLE_productName___Listener?

    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
    }
}
