import Foundation
import UIKit
import MOExampleDevToolPackage
import UserInterface

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = UIViewController()
        vc.title = "UserInterface"
        vc.view.backgroundColor = .systemYellow
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: vc)
        self.window?.makeKeyAndVisible()

        DevTool.startTouchVisualizer()

        return true
    }
}
