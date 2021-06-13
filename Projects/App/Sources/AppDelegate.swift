import UIKit
import NetworkAPI
import AnalyticsKit
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {

        #if DEBUG
        PrepareDevelopToolService.load()
        #endif
        
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
    
        print(Logger.Firebase.register(bundle: .main, plistName: "GoogleService-Info"))
        
        return true
    }
}
