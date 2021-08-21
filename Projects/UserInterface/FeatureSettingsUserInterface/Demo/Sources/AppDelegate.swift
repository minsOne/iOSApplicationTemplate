import UIKit
import FeatureSettingsUserInterface

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = SetttingsViewController()
        viewController.view.backgroundColor = .systemRed
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
import DesignSystem

struct SetttingsViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            SetttingsViewController()
        }
    }
}
#endif
