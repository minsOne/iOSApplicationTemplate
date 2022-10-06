import Foundation
import MOThirdPartyLibManager
import MOFeatureBaseDependencyDomain
import MOFeatureLoanDomain
import MOFeatureLoanRepository

public struct MOFeatureKit {
    public init() {
        _ = MOFeatureLoanRepository.Repository.self
        _ = MOFeatureBaseDependencyDomain.Domain.init()
    }
}
