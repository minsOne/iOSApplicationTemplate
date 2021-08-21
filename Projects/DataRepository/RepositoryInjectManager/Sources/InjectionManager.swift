import Swinject
import InjectPropertyWrapper
import ThirdPartyLibraryManager
import FeatureSettingsDomain
import FeatureSettingsDataRepository

public struct InjectContainerManager {
    public init() {}

    public func register() {
        let container = InjectContainer.container

        container.register(FeatureSettingsDomain.SettingsRepository.self) { _ in FeatureSettingsDataRepository.SettingsRepositoryImpl() }
    }
}
