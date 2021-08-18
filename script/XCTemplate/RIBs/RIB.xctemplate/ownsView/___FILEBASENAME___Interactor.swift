//___FILEHEADER___

import RIBs
import RxSwift

protocol ___VARIABLE_productName___Routing: ViewableRouting {}

protocol ___VARIABLE_productName___Presentable: Presentable {
    var listener: ___VARIABLE_productName___PresentableListener? { get set }
}

protocol ___VARIABLE_productName___Listener: AnyObject {}

final class ___VARIABLE_productName___Interactor: PresentableInteractor<___VARIABLE_productName___Presentable>, ___VARIABLE_productName___Interactable, ___VARIABLE_productName___PresentableListener {

    weak var router: ___VARIABLE_productName___Routing?
    weak var listener: ___VARIABLE_productName___Listener?

    override init(presenter: ___VARIABLE_productName___Presentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
}
