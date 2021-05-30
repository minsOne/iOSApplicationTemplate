import UIKit
import NetworkAPI
#if canImport(DevelopTool)
import DevelopTool
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        prepareDevelopTool()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        #if DEBUG
        HTTPBinGet().request(completion: { result in
            print(result)
        })
        #endif
        
        return true
    }
}

extension AppDelegate {
    func prepareDevelopTool() {
        #if canImport(DevelopTool)
        HTTPStubs.setup()
        #endif
    }
}
