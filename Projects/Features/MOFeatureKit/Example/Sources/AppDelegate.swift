import Foundation
import UIKit
import MOFeatureKit
import MOThirdPartyLibManager
import MOFeatureBaseDependencyDomain
import MOFeatureLoanDomain
import MOFeatureLoanRepository
import MOAppLogger
import MONetworkAPIs
import MOCoreKit
import MONetworkAPIKit
import Swinject
import Alamofire
import MOFoundationKit
import MONetworkAPIHome
import MONetworkAPICommon

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
       
        _ = MOFeatureKit.init()
        
        _ = MOFeatureLoanRepository.Repository.self
        _ = MOFeatureBaseDependencyDomain.Domain.init()
        
        _ = Logger.Crashlytics.self
        _ = MOCoreKit()
        _ = MONetworkAPIKit.init()
        
        _  = MONetworkAPIHome.init()
        
        _ = MOFeatureLoanDomain.Mock10.init()
        _ = MOFeatureLoanDomain.Domain.init()
        _ = MONetworkAPICommon.Mock8.init()
        let a = 10
        print(a.addWon)
        
        return true
        
        
    }
}
