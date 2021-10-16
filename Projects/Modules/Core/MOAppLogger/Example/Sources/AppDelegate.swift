import Foundation
import UIKit
import MOAppLogger
import TouchVisualizer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = UIViewController()
        vc.title = "MOAppLogger"
        vc.view.backgroundColor = .systemYellow
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: vc)
        self.window?.makeKeyAndVisible()

        Logger.Firebase.register(bundle: .main, plistName: "GoogleService-Info")
        Logger.Firebase.logEvent(event: .appStart)

        Visualizer.start()

        return true
    }
}
