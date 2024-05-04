import Foundation
import ProjectDescription

public extension Dep.Project.Feature {
    enum Loan {}
}

public extension Dep.Project.Feature.Loan {
    static let UserInterface = Dep.feature(name: "FeatureLoanUserInterface", path: "Loan/FeatureLoan/UserInterface")
    static let Domain = Dep.feature(name: "FeatureLoanDomain", path: "Loan/FeatureLoan/Domain")
    static let DataRepository = Dep.feature(name: "FeatureLoanDataRepository", path: "Loan/FeatureLoan/DataRepository")
    static let Pacakge: [Dep] = [UserInterface, Domain, DataRepository]
}
