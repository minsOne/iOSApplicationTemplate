import Swinject
import InjectPropertyWrapper
import FeatureSettingsDomain
import FeatureSettingsDataRepository

extension Container: InjectPropertyWrapper.Resolver {}

public struct InjectContainerManager {
    public init() {}

    public func register() {
        let container = Container()
        InjectSettings.resolver = container

        container.register(FeatureSettingsRepository.self) { _ in FeatureSettingsRepositoryImpl() }
    }
}
