import Foundation
import UIKit
import MOFeatureKit
import MOThirdPartyLibManager
import MOFeatureBaseDependencyDomain
import MOFeatureLoanDomain
import MOFeatureLoanRepository

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = UIViewController()
        vc.title = "MOFeatureKit"
        vc.view.backgroundColor = .systemYellow
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: vc)
        self.window?.makeKeyAndVisible()
        
        _ = MOFeatureLoanRepository.Repository.self
        _ = MOFeatureBaseDependencyDomain.Domain.init()
        
        return true
    }
}
