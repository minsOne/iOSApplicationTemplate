//___FILEHEADER___

import RIBs

protocol ___VARIABLE_productName___Dependency: Dependency {
    var ___VARIABLE_productName___ViewController: ___VARIABLE_productName___ViewControllable { get }
}

final class ___VARIABLE_productName___Component: Component<___VARIABLE_productName___Dependency> {
    fileprivate var ___VARIABLE_productName___ViewController: ___VARIABLE_productName___ViewControllable {
        return dependency.___VARIABLE_productName___ViewController
    }
}

// MARK: - Builder

protocol ___VARIABLE_productName___Buildable: Buildable {
    func build(withListener listener: ___VARIABLE_productName___Listener) -> ___VARIABLE_productName___Routing
}

final class ___VARIABLE_productName___Builder: Builder<___VARIABLE_productName___Dependency>, ___VARIABLE_productName___Buildable {

    override init(dependency: ___VARIABLE_productName___Dependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ___VARIABLE_productName___Listener) -> ___VARIABLE_productName___Routing {
        typealias Component = ___VARIABLE_productName___Component
        typealias interactor = ___VARIABLE_productName___Interactor
        typealias Router = ___VARIABLE_productName___Router

        let component = Component(dependency: dependency)
        let interactor = interactor()
        interactor.listener = listener
        return Router(interactor: interactor, viewController: component.___VARIABLE_productName___ViewController)
    }
}
