import Foundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = UIViewController()
        vc.title = "MOCoreKit"
        vc.view.backgroundColor = .systemYellow
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(root: vc)
        self.window?.makeKeyAndVisible()
        return true
    }
}
